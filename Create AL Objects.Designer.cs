namespace NavToBC
{
    partial class Form4
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.backBttn = new System.Windows.Forms.Button();
            this.storeFolderPathLbl = new System.Windows.Forms.Label();
            this.storeFolderPathTextbox = new System.Windows.Forms.TextBox();
            this.executeMessageLbl = new System.Windows.Forms.Label();
            this.executeMessageTextbox = new System.Windows.Forms.TextBox();
            this.deltaFolderPathBttn = new System.Windows.Forms.Button();
            this.executeCommandPreviewStatusLbl = new System.Windows.Forms.Label();
            this.storeFolderPathBttn = new System.Windows.Forms.Button();
            this.executeCommandPreviewBttn = new System.Windows.Forms.Button();
            this.deltaFolderPathTextbox = new System.Windows.Forms.TextBox();
            this.deltaFolderPathLbl = new System.Windows.Forms.Label();
            this.commandPreviewLbl = new System.Windows.Forms.Label();
            this.commandPreviewTextbox = new System.Windows.Forms.TextBox();
            this.extensionStartIdLbl = new System.Windows.Forms.Label();
            this.extensionStartIdTextbox = new System.Windows.Forms.TextBox();
            this.txt2alPathBttn = new System.Windows.Forms.Button();
            this.txt2alPathTextbox = new System.Windows.Forms.TextBox();
            this.txt2alPathLbl = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // backBttn
            // 
            this.backBttn.Font = new System.Drawing.Font("Segoe UI", 15.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.backBttn.Location = new System.Drawing.Point(12, 397);
            this.backBttn.Name = "backBttn";
            this.backBttn.Size = new System.Drawing.Size(776, 39);
            this.backBttn.TabIndex = 5;
            this.backBttn.Text = "Back";
            this.backBttn.UseVisualStyleBackColor = true;
            this.backBttn.Click += new System.EventHandler(this.backBttn_Click);
            // 
            // storeFolderPathLbl
            // 
            this.storeFolderPathLbl.AutoSize = true;
            this.storeFolderPathLbl.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.storeFolderPathLbl.Location = new System.Drawing.Point(12, 253);
            this.storeFolderPathLbl.Name = "storeFolderPathLbl";
            this.storeFolderPathLbl.Size = new System.Drawing.Size(108, 21);
            this.storeFolderPathLbl.TabIndex = 2;
            this.storeFolderPathLbl.Text = "AL folder path";
            // 
            // storeFolderPathTextbox
            // 
            this.storeFolderPathTextbox.Location = new System.Drawing.Point(12, 277);
            this.storeFolderPathTextbox.Name = "storeFolderPathTextbox";
            this.storeFolderPathTextbox.Size = new System.Drawing.Size(307, 23);
            this.storeFolderPathTextbox.TabIndex = 3;
            // 
            // executeMessageLbl
            // 
            this.executeMessageLbl.AutoSize = true;
            this.executeMessageLbl.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.executeMessageLbl.Location = new System.Drawing.Point(568, 107);
            this.executeMessageLbl.Name = "executeMessageLbl";
            this.executeMessageLbl.Size = new System.Drawing.Size(71, 21);
            this.executeMessageLbl.TabIndex = 9;
            this.executeMessageLbl.Text = "Message";
            // 
            // executeMessageTextbox
            // 
            this.executeMessageTextbox.Location = new System.Drawing.Point(409, 132);
            this.executeMessageTextbox.Multiline = true;
            this.executeMessageTextbox.Name = "executeMessageTextbox";
            this.executeMessageTextbox.ReadOnly = true;
            this.executeMessageTextbox.Size = new System.Drawing.Size(379, 241);
            this.executeMessageTextbox.TabIndex = 8;
            this.executeMessageTextbox.Text = "OK";
            // 
            // deltaFolderPathBttn
            // 
            this.deltaFolderPathBttn.Location = new System.Drawing.Point(325, 203);
            this.deltaFolderPathBttn.Name = "deltaFolderPathBttn";
            this.deltaFolderPathBttn.Size = new System.Drawing.Size(75, 24);
            this.deltaFolderPathBttn.TabIndex = 7;
            this.deltaFolderPathBttn.Text = "Open";
            this.deltaFolderPathBttn.UseVisualStyleBackColor = true;
            this.deltaFolderPathBttn.Click += new System.EventHandler(this.deltaFolderPathBttn_Click);
            // 
            // executeCommandPreviewStatusLbl
            // 
            this.executeCommandPreviewStatusLbl.AutoSize = true;
            this.executeCommandPreviewStatusLbl.Location = new System.Drawing.Point(678, 74);
            this.executeCommandPreviewStatusLbl.Name = "executeCommandPreviewStatusLbl";
            this.executeCommandPreviewStatusLbl.Size = new System.Drawing.Size(57, 15);
            this.executeCommandPreviewStatusLbl.TabIndex = 6;
            this.executeCommandPreviewStatusLbl.Text = "Waiting...";
            // 
            // storeFolderPathBttn
            // 
            this.storeFolderPathBttn.Location = new System.Drawing.Point(325, 276);
            this.storeFolderPathBttn.Name = "storeFolderPathBttn";
            this.storeFolderPathBttn.Size = new System.Drawing.Size(75, 24);
            this.storeFolderPathBttn.TabIndex = 7;
            this.storeFolderPathBttn.Text = "Open";
            this.storeFolderPathBttn.UseVisualStyleBackColor = true;
            this.storeFolderPathBttn.Click += new System.EventHandler(this.storeFolderPathBttn_Click);
            // 
            // executeCommandPreviewBttn
            // 
            this.executeCommandPreviewBttn.Location = new System.Drawing.Point(627, 35);
            this.executeCommandPreviewBttn.Name = "executeCommandPreviewBttn";
            this.executeCommandPreviewBttn.Size = new System.Drawing.Size(161, 36);
            this.executeCommandPreviewBttn.TabIndex = 5;
            this.executeCommandPreviewBttn.Text = "Execute Command";
            this.executeCommandPreviewBttn.UseVisualStyleBackColor = true;
            this.executeCommandPreviewBttn.Click += new System.EventHandler(this.executeCommandPreviewBttn_Click);
            // 
            // deltaFolderPathTextbox
            // 
            this.deltaFolderPathTextbox.Location = new System.Drawing.Point(12, 204);
            this.deltaFolderPathTextbox.Name = "deltaFolderPathTextbox";
            this.deltaFolderPathTextbox.Size = new System.Drawing.Size(307, 23);
            this.deltaFolderPathTextbox.TabIndex = 3;
            // 
            // deltaFolderPathLbl
            // 
            this.deltaFolderPathLbl.AutoSize = true;
            this.deltaFolderPathLbl.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.deltaFolderPathLbl.Location = new System.Drawing.Point(12, 179);
            this.deltaFolderPathLbl.Name = "deltaFolderPathLbl";
            this.deltaFolderPathLbl.Size = new System.Drawing.Size(126, 21);
            this.deltaFolderPathLbl.TabIndex = 2;
            this.deltaFolderPathLbl.Text = "Delta folder path";
            // 
            // commandPreviewLbl
            // 
            this.commandPreviewLbl.AutoSize = true;
            this.commandPreviewLbl.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.commandPreviewLbl.Location = new System.Drawing.Point(12, 14);
            this.commandPreviewLbl.Name = "commandPreviewLbl";
            this.commandPreviewLbl.Size = new System.Drawing.Size(142, 21);
            this.commandPreviewLbl.TabIndex = 1;
            this.commandPreviewLbl.Text = "Command Preview";
            // 
            // commandPreviewTextbox
            // 
            this.commandPreviewTextbox.Location = new System.Drawing.Point(12, 43);
            this.commandPreviewTextbox.Name = "commandPreviewTextbox";
            this.commandPreviewTextbox.ReadOnly = true;
            this.commandPreviewTextbox.Size = new System.Drawing.Size(601, 23);
            this.commandPreviewTextbox.TabIndex = 0;
            this.commandPreviewTextbox.TextChanged += new System.EventHandler(this.commandPreviewTextbox_TextChanged);
            // 
            // extensionStartIdLbl
            // 
            this.extensionStartIdLbl.AutoSize = true;
            this.extensionStartIdLbl.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.extensionStartIdLbl.Location = new System.Drawing.Point(15, 326);
            this.extensionStartIdLbl.Name = "extensionStartIdLbl";
            this.extensionStartIdLbl.Size = new System.Drawing.Size(131, 21);
            this.extensionStartIdLbl.TabIndex = 2;
            this.extensionStartIdLbl.Text = "Extension Start ID";
            // 
            // extensionStartIdTextbox
            // 
            this.extensionStartIdTextbox.Location = new System.Drawing.Point(15, 350);
            this.extensionStartIdTextbox.Name = "extensionStartIdTextbox";
            this.extensionStartIdTextbox.Size = new System.Drawing.Size(388, 23);
            this.extensionStartIdTextbox.TabIndex = 3;
            this.extensionStartIdTextbox.TextChanged += new System.EventHandler(this.extensionStartIdTextbox_TextChanged);
            // 
            // txt2alPathBttn
            // 
            this.txt2alPathBttn.Location = new System.Drawing.Point(325, 131);
            this.txt2alPathBttn.Name = "txt2alPathBttn";
            this.txt2alPathBttn.Size = new System.Drawing.Size(75, 24);
            this.txt2alPathBttn.TabIndex = 7;
            this.txt2alPathBttn.Text = "Open";
            this.txt2alPathBttn.UseVisualStyleBackColor = true;
            this.txt2alPathBttn.Click += new System.EventHandler(this.txt2alPathBttn_Click);
            // 
            // txt2alPathTextbox
            // 
            this.txt2alPathTextbox.Location = new System.Drawing.Point(12, 132);
            this.txt2alPathTextbox.Name = "txt2alPathTextbox";
            this.txt2alPathTextbox.Size = new System.Drawing.Size(307, 23);
            this.txt2alPathTextbox.TabIndex = 3;
            // 
            // txt2alPathLbl
            // 
            this.txt2alPathLbl.AutoSize = true;
            this.txt2alPathLbl.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.txt2alPathLbl.Location = new System.Drawing.Point(12, 107);
            this.txt2alPathLbl.Name = "txt2alPathLbl";
            this.txt2alPathLbl.Size = new System.Drawing.Size(85, 21);
            this.txt2alPathLbl.TabIndex = 2;
            this.txt2alPathLbl.Text = "Txt2al path";
            // 
            // Form4
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.txt2alPathLbl);
            this.Controls.Add(this.txt2alPathTextbox);
            this.Controls.Add(this.txt2alPathBttn);
            this.Controls.Add(this.extensionStartIdTextbox);
            this.Controls.Add(this.extensionStartIdLbl);
            this.Controls.Add(this.commandPreviewTextbox);
            this.Controls.Add(this.commandPreviewLbl);
            this.Controls.Add(this.deltaFolderPathLbl);
            this.Controls.Add(this.deltaFolderPathTextbox);
            this.Controls.Add(this.executeCommandPreviewBttn);
            this.Controls.Add(this.storeFolderPathBttn);
            this.Controls.Add(this.executeCommandPreviewStatusLbl);
            this.Controls.Add(this.deltaFolderPathBttn);
            this.Controls.Add(this.executeMessageTextbox);
            this.Controls.Add(this.executeMessageLbl);
            this.Controls.Add(this.storeFolderPathTextbox);
            this.Controls.Add(this.storeFolderPathLbl);
            this.Controls.Add(this.backBttn);
            this.Name = "Create AL Objects";
            this.Text = "Create AL Objects";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button backBttn;
        private System.Windows.Forms.Label storeFolderPathLbl;
        private System.Windows.Forms.TextBox storeFolderPathTextbox;
        private System.Windows.Forms.Label executeMessageLbl;
        private System.Windows.Forms.TextBox executeMessageTextbox;
        private System.Windows.Forms.Button deltaFolderPathBttn;
        private System.Windows.Forms.Label executeCommandPreviewStatusLbl;
        private System.Windows.Forms.Button storeFolderPathBttn;
        private System.Windows.Forms.Button executeCommandPreviewBttn;
        private System.Windows.Forms.TextBox deltaFolderPathTextbox;
        private System.Windows.Forms.Label deltaFolderPathLbl;
        private System.Windows.Forms.Label commandPreviewLbl;
        private System.Windows.Forms.TextBox commandPreviewTextbox;
        private System.Windows.Forms.Label extensionStartIdLbl;
        private System.Windows.Forms.TextBox extensionStartIdTextbox;
        private System.Windows.Forms.Button txt2alPathBttn;
        private System.Windows.Forms.TextBox txt2alPathTextbox;
        private System.Windows.Forms.Label txt2alPathLbl;
    }
}