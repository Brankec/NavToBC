using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace NavToBC
{
    public partial class Form3 : Form
    {
        Timer timer = new Timer();

        public Form3()
        {
            InitializeComponent();

            if (!IsShellFound())
            {
                MessageBox.Show("Powershell folder for generating delta files could not be found, closing the program!");
                Environment.Exit(1);
            }
            else
            {
                ModifyPowershellScript();
                UpdateCommandPreviewtextbox();
            }
        }

        void timer_Tick(object sender, System.EventArgs e)
        {
            executeCommandBttn.Enabled = true;
            timer.Stop();
        }

        public bool IsDirectoryEmpty(string path)
        {
            return Directory.EnumerateFileSystemEntries(path).Any();
        }

        private bool CheckAllFields()
        {
            if (modifiedPathTextbox.Text == "" || deltaPathTextbox.Text == "")
            {
                return false;
            }
            return true;
        }

        private void UpdateCommandPreviewtextbox()
        {
            if (originalPathTextbox.Text == "")
            {
                commandPreviewTextbox.Text = String.Format(@"Compare-NAVApplicationObject " + " -ModifiedPath \"{1}\" -ExportToNewSyntax", originalPathTextbox.Text, modifiedPathTextbox.Text);
            }
            else
            {
                commandPreviewTextbox.Text = String.Format(@"Compare-NAVApplicationObject -OriginalPath " + "\"{0}\" -ModifiedPath \"{1}\" -ExportToNewSyntax", originalPathTextbox.Text, modifiedPathTextbox.Text);
            }
        }

        private void ModifyPowershellScript()
        {
            try
            {
                var scriptFile = File.ReadAllLines(@".\Powershell\Dependencies\NavAdminTool.ps1");
                var scriptText = new List<string>(scriptFile);
                string line;
                int index;

                index = scriptText.FindIndex(x => x.Contains("$nstPath = "));
                line = scriptText[index];

                int position = line.IndexOf("=");
                if (position > 0)
                {
                    line = line.Substring(0, position + 1);
                }

                if(line.Length > 0)
                {
                    line += String.Format(" \"{0}\"", Directory.GetCurrentDirectory() + @"\Powershell\Dependencies");

                    scriptFile[index] = line;
                }

                File.WriteAllLines(@".\Powershell\Dependencies\NavAdminTool.ps1", scriptFile);

            }
            catch(Exception ex)
            {
                executeMessageTextbox.Text = ex.Message;
            }
        }

        private bool IsShellFound()
        {
            if (Directory.Exists("Powershell"))
            {
                return true;
            }

            return false;
        }

        private void commandPreviewTextbox_TextChanged(object sender, EventArgs e)
        {

        }

        private void executeCommandBttn_Click(object sender, EventArgs e)
        {
            if (CheckAllFields())
            {
                timer.Interval = 2000;
                timer.Tick += timer_Tick;
                timer.Start();
                executeCommandBttn.Enabled = false;

                if (IsDirectoryEmpty(deltaPathTextbox.Text))
                {
                    DialogResult result = MessageBox.Show("The directory for delta files is not empty, empty directory?", "Warning", MessageBoxButtons.YesNo);
                    if (result.Equals(DialogResult.Yes))
                    {
                        System.IO.DirectoryInfo di = new DirectoryInfo(deltaPathTextbox.Text);

                        foreach (FileInfo file in di.GetFiles())
                        {
                            file.Delete();
                        }
                        foreach (DirectoryInfo dir in di.GetDirectories())
                        {
                            dir.Delete(true);
                        }
                    }
                }

                executeStatusLbl.Text = "Running...";
                try
                {
                    Process p = new Process();
                    ProcessStartInfo info = new ProcessStartInfo();
                    info.FileName = @"cmd.exe";
                    info.Verb = "runas";
                    info.RedirectStandardInput = true;
                    info.UseShellExecute = false;

                    p.StartInfo = info;
                    p.Start();

                    using (StreamWriter sw = p.StandardInput)
                    {
                        if (sw.BaseStream.CanWrite)
                        {
                            sw.WriteLine(String.Format(@"C:\Windows\system32\WindowsPowerShell\v1.0\PowerShell.exe -NoExit -ExecutionPolicy RemoteSigned " + "\" & " + "'{0}' \"", String.Format("{0}", Directory.GetCurrentDirectory() + @"\Powershell\Dependencies\NavModelTools.ps1")));
                            sw.WriteLine(commandPreviewTextbox.Text);

                            if (originalPathTextbox.Text == "")
                            {
                                sw.WriteLine(Directory.GetCurrentDirectory());
                                sw.WriteLine("");
                            }

                            sw.WriteLine(deltaPathTextbox.Text);
                        }
                    }

                    executeStatusLbl.Text = "Complete!";
                    executeMessageTextbox.Text = "OK";
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

        private void originalPathTextbox_TextChanged(object sender, EventArgs e)
        {
            UpdateCommandPreviewtextbox();
        }

        private void originalPathBttn_Click(object sender, EventArgs e)
        {
            OpenFileDialog choofdlog = new OpenFileDialog();
            choofdlog.InitialDirectory = Directory.GetCurrentDirectory();
            choofdlog.Filter = "All Files (*.*)|*.*";
            choofdlog.FilterIndex = 1;
            choofdlog.Multiselect = false;

            if (choofdlog.ShowDialog() == DialogResult.OK)
            {
                originalPathTextbox.Text = choofdlog.FileName;         
            }
            UpdateCommandPreviewtextbox();
        }

        private void modifiedPathTextbox_TextChanged(object sender, EventArgs e)
        {
            UpdateCommandPreviewtextbox();
        }

        private void modifiedPathBttn_Click(object sender, EventArgs e)
        {
            OpenFileDialog choofdlog = new OpenFileDialog();
            choofdlog.InitialDirectory = Directory.GetCurrentDirectory();
            choofdlog.Filter = "All Files (*.*)|*.*";
            choofdlog.FilterIndex = 1;
            choofdlog.Multiselect = false;
            
            if (choofdlog.ShowDialog() == DialogResult.OK)
            {
                modifiedPathTextbox.Text = choofdlog.FileName;
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

        private void modifiedPath_Click(object sender, EventArgs e)
        {
            UpdateCommandPreviewtextbox();
        }

        private void deltaPathBttn_Click(object sender, EventArgs e)
        {
            FolderBrowserDialog fbd = new FolderBrowserDialog();
            fbd.SelectedPath = Directory.GetCurrentDirectory() + @"\Delta";
            fbd.Description = "Custom Description";

            if (fbd.ShowDialog() == DialogResult.OK)
            {
                deltaPathTextbox.Text = fbd.SelectedPath;
            }
            UpdateCommandPreviewtextbox();
        }

        private void deltaPathTextbox_TextChanged(object sender, EventArgs e)
        {
            UpdateCommandPreviewtextbox();
        }
    }
}
