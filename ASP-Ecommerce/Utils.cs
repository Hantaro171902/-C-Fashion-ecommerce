using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;

namespace ASP_Ecommerce
{
    public class Utils
    {
        private static SqlConnection con; // = null;

        public static SqlConnection GetConnection()
        {
            return con ?? throw new InvalidOperationException("Connection is not initialized.");
        }

        public static void OpenConnection()
        {
            try
            {
                con = new SqlConnection("Server=DESKTOP-L8SPRR5\\SQLEXPRESS; Database=EC_FashionStore; Integrated Security=True");
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                    Console.WriteLine("Connection is opened");
                }

            }
            catch (Exception ex)
            {
                throw new Exception("Failed to open connection: " + ex.Message);
            }
        }

        public static void CloseConnection()
        {
            try
            {
                if (con != null && con.State != System.Data.ConnectionState.Closed)
                {
                    con.Close();
                    Console.WriteLine("Connection is closed");
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Failed to close connection: " + ex.Message);
            }
        }

        public static bool isValidExtension(string fileName)
        {
            bool isValid = false;
            string[] fileExtension = { ".jpg", ".jpeg", ".png", ".gif" };
            foreach (string file in fileExtension)
            {
                if (fileName.Contains(file))
                {
                    isValid = true;
                    break;
                }
            }
            return isValid;
        }

        public static string getUniqueId()
        {
            Guid guid = Guid.NewGuid();
            return guid.ToString();
        }
    }
}