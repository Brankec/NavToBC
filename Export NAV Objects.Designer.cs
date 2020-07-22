namespace NavToBC
{
    partial class Form2
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
            this.finalCommandTextbox = new System.Windows.Forms.TextBox();
            this.CommandLabel = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.finsqlLocationTextbox = new System.Windows.Forms.TextBox();
            this.databaseNameLbl = new System.Windows.Forms.Label();
            this.databasenameTextbox = new System.Windows.Forms.TextBox();
            this.serverNameLbl = new System.Windows.Forms.Label();
            this.serverNameTextbox = new System.Windows.Forms.TextBox();
            this.executeCommandBttn = new System.Windows.Forms.Button();
            this.filterTypeLbl = new System.Windows.Forms.Label();
            this.filterTypeTextbox = new System.Windows.Forms.TextBox();
            this.executeStatusLbl = new System.Windows.Forms.Label();
            this.idParametersLbl = new System.Windows.Forms.Label();
            this.idParametersTextbox = new System.Windows.Forms.TextBox();
            this.openFinsqlLocationBttn = new System.Windows.Forms.Button();
            this.executeMessageTextbox = new System.Windows.Forms.TextBox();
            this.executeMessageLbl = new System.Windows.Forms.Label();
            this.storeFilePathTextbox = new System.Windows.Forms.TextBox();
            this.filePathLbl = new System.Windows.Forms.Label();
            this.storeFilePathBttn = new System.Windows.Forms.Button();
            this.backBtn = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // finalCommandTextbox
            // 
            this.finalCommandTextbox.Location = new System.Drawing.Point(12, 38);
            this.finalCommandTextbox.Name = "finalCommandTextbox";
            this.finalCommandTextbox.ReadOnly = true;
            this.finalCommandTextbox.Size = new System.Drawing.Size(601, 23);
            this.finalCommandTextbox.TabIndex = 0;
            this.finalCommandTextbox.TextChanged += new System.EventHandler(this.finalCommandTextbox_TextChanged);
            // 
            // CommandLabel
            // 
            this.CommandLabel.AutoSize = true;
            this.CommandLabel.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.CommandLabel.Location = new System.Drawing.Point(12, 9);
            this.CommandLabel.Name = "CommandLabel";
            this.CommandLabel.Size = new System.Drawing.Size(142, 21);
            this.CommandLabel.TabIndex = 1;
            this.CommandLabel.Text = "Command Preview";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label1.Location = new System.Drawing.Point(12, 102);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(133, 21);
            this.label1.TabIndex = 2;
            this.label1.Text = "finsql.exe location";
            // 
            // finsqlLocationTextbox
            // 
            this.finsqlLocationTextbox.Location = new System.Drawing.Point(12, 126);
            this.finsqlLocationTextbox.Name = "finsqlLocationTextbox";
            this.finsqlLocationTextbox.Size = new System.Drawing.Size(323, 23);
            this.finsqlLocationTextbox.TabIndex = 3;
            this.finsqlLocationTextbox.TextChanged += new System.EventHandler(this.textBox2_TextChanged);
            // 
            // databaseNameLbl
            // 
            this.databaseNameLbl.AutoSize = true;
            this.databaseNameLbl.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.databaseNameLbl.Location = new System.Drawing.Point(12, 241);
            this.databaseNameLbl.Name = "databaseNameLbl";
            this.databaseNameLbl.Size = new System.Drawing.Size(117, 21);
            this.databaseNameLbl.TabIndex = 2;
            this.databaseNameLbl.Text = "Database name";
            // 
            // databasenameTextbox
            // 
            this.databasenameTextbox.Location = new System.Drawing.Point(12, 265);
            this.databasenameTextbox.Name = "databasenameTextbox";
            this.databasenameTextbox.Size = new System.Drawing.Size(404, 23);
            this.databasenameTextbox.TabIndex = 3;
            this.databasenameTextbox.TextChanged += new System.EventHandler(this.databasenameTextbox_TextChanged);
            // 
            // serverNameLbl
            // 
            this.serverNameLbl.AutoSize = true;
            this.serverNameLbl.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.serverNameLbl.Location = new System.Drawing.Point(12, 314);
            this.serverNameLbl.Name = "serverNameLbl";
            this.serverNameLbl.Size = new System.Drawing.Size(98, 21);
            this.serverNameLbl.TabIndex = 2;
            this.serverNameLbl.Text = "Server name";
            // 
            // serverNameTextbox
            // 
            this.serverNameTextbox.Location = new System.Drawing.Point(12, 338);
            this.serverNameTextbox.Name = "serverNameTextbox";
            this.serverNameTextbox.Size = new System.Drawing.Size(404, 23);
            this.serverNameTextbox.TabIndex = 3;
            this.serverNameTextbox.TextChanged += new System.EventHandler(this.serverNameTextbox_TextChanged);
            // 
            // executeCommandBttn
            // 
            this.executeCommandBttn.Location = new System.Drawing.Point(627, 30);
            this.executeCommandBttn.Name = "executeCommandBttn";
            this.executeCommandBttn.Size = new System.Drawing.Size(161, 36);
            this.executeCommandBttn.TabIndex = 5;
            this.executeCommandBttn.Text = "Execute Command";
            this.executeCommandBttn.UseVisualStyleBackColor = true;
            this.executeCommandBttn.Click += new System.EventHandler(this.executeCommandBttn_Click);
            // 
            // filterTypeLbl
            // 
            this.filterTypeLbl.AutoSize = true;
            this.filterTypeLbl.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.filterTypeLbl.Location = new System.Drawing.Point(487, 102);
            this.filterTypeLbl.Name = "filterTypeLbl";
            this.filterTypeLbl.Size = new System.Drawing.Size(45, 21);
            this.filterTypeLbl.TabIndex = 2;
            this.filterTypeLbl.Text = "Filter";
            this.filterTypeLbl.Click += new System.EventHandler(this.filterTypeLbl_Click);
            // 
            // filterTypeTextbox
            // 
            this.filterTypeTextbox.Location = new System.Drawing.Point(487, 126);
            this.filterTypeTextbox.Name = "filterTypeTextbox";
            this.filterTypeTextbox.Size = new System.Drawing.Size(133, 23);
            this.filterTypeTextbox.TabIndex = 3;
            this.filterTypeTextbox.TextChanged += new System.EventHandler(this.filterTypeTextbox_TextChanged);
            // 
            // executeStatusLbl
            // 
            this.executeStatusLbl.AutoSize = true;
            this.executeStatusLbl.Location = new System.Drawing.Point(678, 69);
            this.executeStatusLbl.Name = "executeStatusLbl";
            this.executeStatusLbl.Size = new System.Drawing.Size(57, 15);
            this.executeStatusLbl.TabIndex = 6;
            this.executeStatusLbl.Text = "Waiting...";
            // 
            // idParametersLbl
            // 
            this.idParametersLbl.AutoSize = true;
            this.idParametersLbl.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.idParametersLbl.Location = new System.Drawing.Point(487, 172);
            this.idParametersLbl.Name = "idParametersLbl";
            this.idParametersLbl.Size = new System.Drawing.Size(108, 21);
            this.idParametersLbl.TabIndex = 2;
            this.idParametersLbl.Text = "ID parameters";
            // 
            // idParametersTextbox
            // 
            this.idParametersTextbox.Location = new System.Drawing.Point(487, 196);
            this.idParametersTextbox.Name = "idParametersTextbox";
            this.idParametersTextbox.Size = new System.Drawing.Size(248, 23);
            this.idParametersTextbox.TabIndex = 3;
            this.idParametersTextbox.TextChanged += new System.EventHandler(this.idParametersTextbox_TextChanged);
            // 
            // openFinsqlLocationBttn
            // 
            this.openFinsqlLocationBttn.Location = new System.Drawing.Point(341, 125);
            this.openFinsqlLocationBttn.Name = "openFinsqlLocationBttn";
            this.openFinsqlLocationBttn.Size = new System.Drawing.Size(75, 24);
            this.openFinsqlLocationBttn.TabIndex = 7;
            this.openFinsqlLocationBttn.Text = "Open";
            this.openFinsqlLocationBttn.UseVisualStyleBackColor = true;
            this.openFinsqlLocationBttn.Click += new System.EventHandler(this.openFinsqlLocationBttn_Click);
            // 
            // executeMessageTextbox
            // 
            this.executeMessageTextbox.Location = new System.Drawing.Point(487, 265);
            this.executeMessageTextbox.Multiline = true;
            this.executeMessageTextbox.Name = "executeMessageTextbox";
            this.executeMessageTextbox.ReadOnly = true;
            this.executeMessageTextbox.Size = new System.Drawing.Size(248, 96);
            this.executeMessageTextbox.TabIndex = 8;
            this.executeMessageTextbox.Text = "OK";
            // 
            // executeMessageLbl
            // 
            this.executeMessageLbl.AutoSize = true;
            this.executeMessageLbl.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.executeMessageLbl.Location = new System.Drawing.Point(574, 241);
            this.executeMessageLbl.Name = "executeMessageLbl";
            this.executeMessageLbl.Size = new System.Drawing.Size(71, 21);
            this.executeMessageLbl.TabIndex = 9;
            this.executeMessageLbl.Text = "Message";
            // 
            // storeFilePathTextbox
            // 
            this.storeFilePathTextbox.Location = new System.Drawing.Point(12, 196);
            this.storeFilePathTextbox.Name = "storeFilePathTextbox";
            this.storeFilePathTextbox.Size = new System.Drawing.Size(323, 23);
            this.storeFilePathTextbox.TabIndex = 3;
            this.storeFilePathTextbox.TextChanged += new System.EventHandler(this.storeFilePathTextbox_TextChanged);
            // 
            // filePathLbl
            // 
            this.filePathLbl.AutoSize = true;
            this.filePathLbl.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.filePathLbl.Location = new System.Drawing.Point(12, 172);
            this.filePathLbl.Name = "filePathLbl";
            this.filePathLbl.Size = new System.Drawing.Size(123, 21);
            this.filePathLbl.TabIndex = 2;
            this.filePathLbl.Text = "Store in file path";
            // 
            // storeFilePathBttn
            // 
            this.storeFilePathBttn.Location = new System.Drawing.Point(341, 196);
            this.storeFilePathBttn.Name = "storeFilePathBttn";
            this.storeFilePathBttn.Size = new System.Drawing.Size(75, 24);
            this.storeFilePathBttn.TabIndex = 7;
            this.storeFilePathBttn.Text = "Open";
            this.storeFilePathBttn.UseVisualStyleBackColor = true;
            this.storeFilePathBttn.Click += new System.EventHandler(this.storeFilePathBttn_Click);
            // 
            // backBtn
            // 
            this.backBtn.Font = new System.Drawing.Font("Segoe UI", 15.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.backBtn.Location = new System.Drawing.Point(12, 385);
            this.backBtn.Name = "backBtn";
            this.backBtn.Size = new System.Drawing.Size(776, 46);
            this.backBtn.TabIndex = 5;
            this.backBtn.Text = "Back";
            this.backBtn.UseVisualStyleBackColor = true;
            this.backBtn.Click += new System.EventHandler(this.backBtn_Click);
            // 
            // Form2
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 443);
            this.Controls.Add(this.backBtn);
            this.Controls.Add(this.storeFilePathBttn);
            this.Controls.Add(this.filePathLbl);
            this.Controls.Add(this.storeFilePathTextbox);
            this.Controls.Add(this.executeMessageLbl);
            this.Controls.Add(this.executeMessageTextbox);
            this.Controls.Add(this.openFinsqlLocationBttn);
            this.Controls.Add(this.idParametersTextbox);
            this.Controls.Add(this.idParametersLbl);
            this.Controls.Add(this.executeStatusLbl);
            this.Controls.Add(this.filterTypeTextbox);
            this.Controls.Add(this.filterTypeLbl);
            this.Controls.Add(this.executeCommandBttn);
            this.Controls.Add(this.serverNameTextbox);
            this.Controls.Add(this.serverNameLbl);
            this.Controls.Add(this.databasenameTextbox);
            this.Controls.Add(this.databaseNameLbl);
            this.Controls.Add(this.finsqlLocationTextbox);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.CommandLabel);
            this.Controls.Add(this.finalCommandTextbox);
            this.Name = "Export NAV Objects";
            this.Text = "Export NAV Objects";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox finalCommandTextbox;
        private System.Windows.Forms.Label CommandLabel;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox finsqlLocationTextbox;
        private System.Windows.Forms.Label databaseNameLbl;
        private System.Windows.Forms.TextBox databasenameTextbox;
        private System.Windows.Forms.Label serverNameLbl;
        private System.Windows.Forms.TextBox serverNameTextbox;
        private System.Windows.Forms.Button executeCommandBttn;
        private System.Windows.Forms.Label filterTypeLbl;
        private System.Windows.Forms.TextBox filterTypeTextbox;
        private System.Windows.Forms.Label executeStatusLbl;
        private System.Windows.Forms.Label idParametersLbl;
        private System.Windows.Forms.TextBox idParametersTextbox;
        private System.Windows.Forms.Button openFinsqlLocationBttn;
        private System.Windows.Forms.TextBox executeMessageTextbox;
        private System.Windows.Forms.Label executeMessageLbl;
        private System.Windows.Forms.TextBox storeFilePathTextbox;
        private System.Windows.Forms.Label filePathLbl;
        private System.Windows.Forms.Button storeFilePathBttn;
        private System.Windows.Forms.Button backBtn;
    }
}