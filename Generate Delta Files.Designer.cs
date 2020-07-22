namespace NavToBC
{
    partial class Form3
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
            this.modifiedPath = new System.Windows.Forms.Label();
            this.modifiedPathTextbox = new System.Windows.Forms.TextBox();
            this.executeMessageLbl = new System.Windows.Forms.Label();
            this.executeMessageTextbox = new System.Windows.Forms.TextBox();
            this.originalPathBttn = new System.Windows.Forms.Button();
            this.executeStatusLbl = new System.Windows.Forms.Label();
            this.modifiedPathBttn = new System.Windows.Forms.Button();
            this.executeCommandBttn = new System.Windows.Forms.Button();
            this.originalPathTextbox = new System.Windows.Forms.TextBox();
            this.originalPath = new System.Windows.Forms.Label();
            this.commandPreviewLbl = new System.Windows.Forms.Label();
            this.commandPreviewTextbox = new System.Windows.Forms.TextBox();
            this.deltaPathBttn = new System.Windows.Forms.Button();
            this.deltaPathLbl = new System.Windows.Forms.Label();
            this.deltaPathTextbox = new System.Windows.Forms.TextBox();
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
            // modifiedPath
            // 
            this.modifiedPath.AutoSize = true;
            this.modifiedPath.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.modifiedPath.Location = new System.Drawing.Point(12, 162);
            this.modifiedPath.Name = "modifiedPath";
            this.modifiedPath.Size = new System.Drawing.Size(132, 21);
            this.modifiedPath.TabIndex = 2;
            this.modifiedPath.Text = "Modified file path";
            this.modifiedPath.Click += new System.EventHandler(this.modifiedPath_Click);
            // 
            // modifiedPathTextbox
            // 
            this.modifiedPathTextbox.Location = new System.Drawing.Point(12, 186);
            this.modifiedPathTextbox.Name = "modifiedPathTextbox";
            this.modifiedPathTextbox.Size = new System.Drawing.Size(695, 23);
            this.modifiedPathTextbox.TabIndex = 3;
            this.modifiedPathTextbox.TextChanged += new System.EventHandler(this.modifiedPathTextbox_TextChanged);
            // 
            // executeMessageLbl
            // 
            this.executeMessageLbl.AutoSize = true;
            this.executeMessageLbl.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.executeMessageLbl.Location = new System.Drawing.Point(366, 279);
            this.executeMessageLbl.Name = "executeMessageLbl";
            this.executeMessageLbl.Size = new System.Drawing.Size(71, 21);
            this.executeMessageLbl.TabIndex = 9;
            this.executeMessageLbl.Text = "Message";
            // 
            // executeMessageTextbox
            // 
            this.executeMessageTextbox.Location = new System.Drawing.Point(160, 303);
            this.executeMessageTextbox.Multiline = true;
            this.executeMessageTextbox.Name = "executeMessageTextbox";
            this.executeMessageTextbox.ReadOnly = true;
            this.executeMessageTextbox.Size = new System.Drawing.Size(477, 78);
            this.executeMessageTextbox.TabIndex = 8;
            this.executeMessageTextbox.Text = "OK";
            // 
            // originalPathBttn
            // 
            this.originalPathBttn.Location = new System.Drawing.Point(713, 114);
            this.originalPathBttn.Name = "originalPathBttn";
            this.originalPathBttn.Size = new System.Drawing.Size(75, 24);
            this.originalPathBttn.TabIndex = 7;
            this.originalPathBttn.Text = "Open";
            this.originalPathBttn.UseVisualStyleBackColor = true;
            this.originalPathBttn.Click += new System.EventHandler(this.originalPathBttn_Click);
            // 
            // executeStatusLbl
            // 
            this.executeStatusLbl.AutoSize = true;
            this.executeStatusLbl.Location = new System.Drawing.Point(678, 74);
            this.executeStatusLbl.Name = "executeStatusLbl";
            this.executeStatusLbl.Size = new System.Drawing.Size(57, 15);
            this.executeStatusLbl.TabIndex = 6;
            this.executeStatusLbl.Text = "Waiting...";
            // 
            // modifiedPathBttn
            // 
            this.modifiedPathBttn.Location = new System.Drawing.Point(713, 186);
            this.modifiedPathBttn.Name = "modifiedPathBttn";
            this.modifiedPathBttn.Size = new System.Drawing.Size(75, 24);
            this.modifiedPathBttn.TabIndex = 7;
            this.modifiedPathBttn.Text = "Open";
            this.modifiedPathBttn.UseVisualStyleBackColor = true;
            this.modifiedPathBttn.Click += new System.EventHandler(this.modifiedPathBttn_Click);
            // 
            // executeCommandBttn
            // 
            this.executeCommandBttn.Location = new System.Drawing.Point(627, 35);
            this.executeCommandBttn.Name = "executeCommandBttn";
            this.executeCommandBttn.Size = new System.Drawing.Size(161, 36);
            this.executeCommandBttn.TabIndex = 5;
            this.executeCommandBttn.Text = "Execute Command";
            this.executeCommandBttn.UseVisualStyleBackColor = true;
            this.executeCommandBttn.Click += new System.EventHandler(this.executeCommandBttn_Click);
            // 
            // originalPathTextbox
            // 
            this.originalPathTextbox.Location = new System.Drawing.Point(12, 115);
            this.originalPathTextbox.Name = "originalPathTextbox";
            this.originalPathTextbox.Size = new System.Drawing.Size(695, 23);
            this.originalPathTextbox.TabIndex = 3;
            this.originalPathTextbox.TextChanged += new System.EventHandler(this.originalPathTextbox_TextChanged);
            // 
            // originalPath
            // 
            this.originalPath.AutoSize = true;
            this.originalPath.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.originalPath.Location = new System.Drawing.Point(12, 91);
            this.originalPath.Name = "originalPath";
            this.originalPath.Size = new System.Drawing.Size(126, 21);
            this.originalPath.TabIndex = 2;
            this.originalPath.Text = "Original file path";
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
            // deltaPathBttn
            // 
            this.deltaPathBttn.Location = new System.Drawing.Point(713, 253);
            this.deltaPathBttn.Name = "deltaPathBttn";
            this.deltaPathBttn.Size = new System.Drawing.Size(75, 24);
            this.deltaPathBttn.TabIndex = 7;
            this.deltaPathBttn.Text = "Open";
            this.deltaPathBttn.UseVisualStyleBackColor = true;
            this.deltaPathBttn.Click += new System.EventHandler(this.deltaPathBttn_Click);
            // 
            // deltaPathLbl
            // 
            this.deltaPathLbl.AutoSize = true;
            this.deltaPathLbl.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.deltaPathLbl.Location = new System.Drawing.Point(12, 229);
            this.deltaPathLbl.Name = "deltaPathLbl";
            this.deltaPathLbl.Size = new System.Drawing.Size(126, 21);
            this.deltaPathLbl.TabIndex = 2;
            this.deltaPathLbl.Text = "Delta folder path";
            // 
            // deltaPathTextbox
            // 
            this.deltaPathTextbox.Location = new System.Drawing.Point(12, 253);
            this.deltaPathTextbox.Name = "deltaPathTextbox";
            this.deltaPathTextbox.Size = new System.Drawing.Size(695, 23);
            this.deltaPathTextbox.TabIndex = 3;
            this.deltaPathTextbox.TextChanged += new System.EventHandler(this.deltaPathTextbox_TextChanged);
            // 
            // Form3
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.deltaPathTextbox);
            this.Controls.Add(this.deltaPathLbl);
            this.Controls.Add(this.deltaPathBttn);
            this.Controls.Add(this.commandPreviewTextbox);
            this.Controls.Add(this.commandPreviewLbl);
            this.Controls.Add(this.originalPath);
            this.Controls.Add(this.originalPathTextbox);
            this.Controls.Add(this.executeCommandBttn);
            this.Controls.Add(this.modifiedPathBttn);
            this.Controls.Add(this.executeStatusLbl);
            this.Controls.Add(this.originalPathBttn);
            this.Controls.Add(this.executeMessageTextbox);
            this.Controls.Add(this.executeMessageLbl);
            this.Controls.Add(this.modifiedPathTextbox);
            this.Controls.Add(this.modifiedPath);
            this.Controls.Add(this.backBttn);
            this.Name = "Generate Delta Files";
            this.Text = "Generate Delta Files";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button backBttn;
        private System.Windows.Forms.Label modifiedPath;
        private System.Windows.Forms.TextBox modifiedPathTextbox;
        private System.Windows.Forms.Label executeMessageLbl;
        private System.Windows.Forms.TextBox executeMessageTextbox;
        private System.Windows.Forms.Button originalPathBttn;
        private System.Windows.Forms.Label executeStatusLbl;
        private System.Windows.Forms.Button modifiedPathBttn;
        private System.Windows.Forms.Button executeCommandBttn;
        private System.Windows.Forms.TextBox originalPathTextbox;
        private System.Windows.Forms.Label originalPath;
        private System.Windows.Forms.Label commandPreviewLbl;
        private System.Windows.Forms.TextBox commandPreviewTextbox;
        private System.Windows.Forms.Button deltaPathBttn;
        private System.Windows.Forms.Label deltaPathLbl;
        private System.Windows.Forms.TextBox deltaPathTextbox;
    }
}