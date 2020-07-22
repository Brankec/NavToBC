using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace NavToBC
{
    static class Program
    {
        /// <summary>
        ///  The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            CreateFolderStructure();

            Application.SetHighDpiMode(HighDpiMode.SystemAware);
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new MainMenu());
        }

        static void CreateFolderStructure()
        {
            string root = Directory.GetCurrentDirectory();

            Directory.CreateDirectory(root + @"\AL");
            Directory.CreateDirectory(root + @"\Delta");
            Directory.CreateDirectory(root + @"\Modified");
            Directory.CreateDirectory(root + @"\Original");
            File.Create(root + @"\Original\Empty.txt");
        }
    }
}
