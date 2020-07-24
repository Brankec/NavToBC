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
    public partial class Form4 : Form
    {
        Timer timer = new Timer();
        public Form4()
        {
            InitializeComponent();
            UpdateCommandPreviewtextbox();
        }

        private bool CheckAllFields()
        {
            if (deltaFolderPathTextbox.Text == "" || storeFolderPathTextbox.Text == "" || extensionStartIdTextbox.Text == "")
            {
                return false;
            }
            return true;
        }

        void timer_Tick(object sender, System.EventArgs e)
        {
            executeCommandPreviewBttn.Enabled = true;
            timer.Stop();
        }

        private void UpdateCommandPreviewtextbox()
        {
            commandPreviewTextbox.Text = String.Format(@"Txt2al --Source=" + "\"{0}\" --Target=\"{1}\" --ExtensionStartId={2}", deltaFolderPathTextbox.Text, storeFolderPathTextbox.Text, extensionStartIdTextbox.Text);
        }

        private void deltaFolderPathBttn_Click(object sender, EventArgs e)
        {
            FolderBrowserDialog fbd = new FolderBrowserDialog();
            fbd.SelectedPath = Directory.GetCurrentDirectory() + @"\Delta";
            fbd.Description = "Custom Description";

            if (fbd.ShowDialog() == DialogResult.OK)
            {
                deltaFolderPathTextbox.Text = fbd.SelectedPath;
            }
            UpdateCommandPreviewtextbox();
        }

        private void commandPreviewTextbox_TextChanged(object sender, EventArgs e)
        {

        }

        private void storeFolderPathBttn_Click(object sender, EventArgs e)
        {
            FolderBrowserDialog fbd = new FolderBrowserDialog();
            fbd.SelectedPath = Directory.GetCurrentDirectory() + @"\AL";
            fbd.Description = "Custom Description";

            if (fbd.ShowDialog() == DialogResult.OK)
            {
                storeFolderPathTextbox.Text = fbd.SelectedPath;
            }
            UpdateCommandPreviewtextbox();
        }

        private void backBttn_Click(object sender, EventArgs e)
        {
            this.Hide();
            var form1 = new MainMenu();
            form1.Closed += (s, args) => this.Close();
            form1.Show();
        }

        private void executeCommandPreviewBttn_Click(object sender, EventArgs e)
        {
            if (CheckAllFields())
            {
                timer.Interval = 2000;
                timer.Tick += timer_Tick;
                timer.Start();
                executeCommandPreviewBttn.Enabled = false;

                executeCommandPreviewStatusLbl.Text = "Running...";
                try
                {
                    Process p = new Process();
                    ProcessStartInfo info = new ProcessStartInfo();
                    info.FileName = @"cmd.exe";
                    info.Verb = "runas";
                    info.RedirectStandardInput = true;
                    info.UseShellExecute = false;
                    info.CreateNoWindow = true;

                    p.StartInfo = info;
                    p.Start();

                    using (StreamWriter sw = p.StandardInput)
                    {
                        if (sw.BaseStream.CanWrite)
                        {
                            sw.WriteLine(String.Format("cd {0}", txt2alPathTextbox.Text));
                            sw.WriteLine(commandPreviewTextbox.Text);
                        }
                    }

                    executeCommandPreviewStatusLbl.Text = "Complete!";
                    executeMessageTextbox.Text = "OK";
                }
                catch (Exception ex)
                {
                    executeMessageTextbox.Text = ex.Message;
                    executeCommandPreviewStatusLbl.Text = "Failed!";
                }
            }
            else
            {
                executeMessageTextbox.Text = "Please fill all fields before executing!";
            }
        }

        private void txt2alPathBttn_Click(object sender, EventArgs e)
        {
            FolderBrowserDialog fbd = new FolderBrowserDialog();
            fbd.Description = "Custom Description";

            if (fbd.ShowDialog() == DialogResult.OK)
            {
                txt2alPathTextbox.Text = fbd.SelectedPath;
            }
            UpdateCommandPreviewtextbox();
        }

        private void extensionStartIdTextbox_TextChanged(object sender, EventArgs e)
        {
            UpdateCommandPreviewtextbox();
        }
    }
}
