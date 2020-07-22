using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Text;
using System.Windows.Forms;

namespace NavToBC
{
    public partial class Form2 : Form
    {
        Timer timer = new Timer();

        public Form2()
        {
            InitializeComponent();



            UpdateFinalCommandtextbox();
        }

        void timer_Tick(object sender, System.EventArgs e)
        {
            executeCommandBttn.Enabled = true;
            timer.Stop();
        }

        private void UpdateFinalCommandtextbox()
        {
            if (filterTypeTextbox.Text.Contains("locked", StringComparison.OrdinalIgnoreCase))
            {
                finalCommandTextbox.Text = String.Format(@"finsql.exe" + " Command=ExportToNewSyntax, File=\"{0}\", Database=\"{1}\", ServerName=\"{2}\", Filter={3}", storeFilePathTextbox.Text, databasenameTextbox.Text, serverNameTextbox.Text, filterTypeTextbox.Text);
            }
            else
            {
                finalCommandTextbox.Text = String.Format(@"finsql.exe" + " Command=ExportToNewSyntax, File=\"{0}\", Database=\"{1}\", ServerName=\"{2}\", Filter={3};ID=\"{4}\"", storeFilePathTextbox.Text, databasenameTextbox.Text, serverNameTextbox.Text, filterTypeTextbox.Text, idParametersTextbox.Text);
            }
        }

        private bool CheckAllFields()
        {
            if (finsqlLocationTextbox.Text == "" || storeFilePathTextbox.Text == "" || databasenameTextbox.Text == "" || serverNameTextbox.Text == "" || filterTypeTextbox.Text == "")
            {
                if(filterTypeTextbox.Text.Contains("locked", StringComparison.OrdinalIgnoreCase) && idParametersTextbox.Text == "")
                {
                    return true;
                }
                return false;
            }
            return true;
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            UpdateFinalCommandtextbox();
        }

        private void finalCommandTextbox_TextChanged(object sender, EventArgs e)
        {
            UpdateFinalCommandtextbox();
        }

        private void openFinsqlLocationBttn_Click(object sender, EventArgs e)
        {
            FolderBrowserDialog fbd = new FolderBrowserDialog();
            fbd.Description = "Custom Description";

            if (fbd.ShowDialog() == DialogResult.OK)
            {
                finsqlLocationTextbox.Text = fbd.SelectedPath;
            }
            UpdateFinalCommandtextbox();
        }

        private void databasenameTextbox_TextChanged(object sender, EventArgs e)
        {
            UpdateFinalCommandtextbox();
        }

        private void serverNameTextbox_TextChanged(object sender, EventArgs e)
        {
            UpdateFinalCommandtextbox();
        }

        private void filterTypeTextbox_TextChanged(object sender, EventArgs e)
        {
            UpdateFinalCommandtextbox();
        }

        private void idParametersTextbox_TextChanged(object sender, EventArgs e)
        {
            UpdateFinalCommandtextbox();
        }

        private void executeCommandBttn_Click(object sender, EventArgs e)
        {
            if (CheckAllFields())
            {
                timer.Interval = 2000;
                timer.Tick += timer_Tick;
                timer.Start();
                executeCommandBttn.Enabled = false;

                executeStatusLbl.Text = "Running...";
                try
                {
                    Process p = new Process();
                    ProcessStartInfo info = new ProcessStartInfo();
                    info.FileName = "cmd.exe";
                    info.RedirectStandardInput = true;
                    info.UseShellExecute = false;

                    p.StartInfo = info;
                    p.Start();

                    using (StreamWriter sw = p.StandardInput)
                    {
                        if (sw.BaseStream.CanWrite)
                        {
                            sw.WriteLine(String.Format("cd {0}", finsqlLocationTextbox.Text));
                            sw.WriteLine(finalCommandTextbox.Text);
                        }
                    }

                    //NAV creates an error log too late for the latter code to catch it so we gotta wait 1 second
                    System.Threading.Thread.Sleep(1000);

                    if (File.Exists(finsqlLocationTextbox.Text + @"\naverrorlog.txt"))
                    {
                        executeStatusLbl.Text = "Failed!";
                        executeMessageTextbox.Text = File.ReadAllText(finsqlLocationTextbox.Text + @"\naverrorlog.txt");
                    }
                    else
                    {
                        executeStatusLbl.Text = "Complete!";
                        executeMessageTextbox.Text = "OK";
                    }
                }
                catch (Exception ex)
                {
                    executeMessageTextbox.Text = ex.Message;
                    executeStatusLbl.Text = "Failed!";
                }
            }
            else
            {
                executeMessageTextbox.Text = "Please fill all fields before executing!";
            }
        }

        private void backBtn_Click(object sender, EventArgs e)
        {
            this.Hide();
            var form1 = new MainMenu();
            form1.Closed += (s, args) => this.Close();
            form1.Show();
        }

        private void filterTypeLbl_Click(object sender, EventArgs e)
        {

        }

        private void storeFilePathBttn_Click(object sender, EventArgs e)
        {
            SaveFileDialog savefile = new SaveFileDialog();
            savefile.FileName = "sample.txt";
            savefile.Filter = "Text files (*.txt)|*.txt|All files (*.*)|*.*";
            savefile.InitialDirectory = Directory.GetCurrentDirectory();

            if (savefile.ShowDialog() == DialogResult.OK)
            {
                storeFilePathTextbox.Text = savefile.FileName;
            }

            UpdateFinalCommandtextbox();
        }

        private void storeFilePathTextbox_TextChanged(object sender, EventArgs e)
        {

        }


    }
}
