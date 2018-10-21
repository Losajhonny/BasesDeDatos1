using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos
{
    class Conexion
    {
        /**
         * Retorna una conexion a la base de datos proyecto1
         * */
        public static SqlConnection connect()
        {
            return new SqlConnection("Data Source=JHONNY-PC\\SQLEXPRESS; Initial Catalog=dbp1; Integrated Security=True");
        }

        /**
         * Abre la conexion a la base de datos
         * */
        public static void openConnect(SqlConnection con)
        {
            if (con.State == System.Data.ConnectionState.Broken || con.State == System.Data.ConnectionState.Closed)
            {
                con.Open();
            }
        }

        /**
         * Cierra la conexion a la base de datos
         * */
        public static void closeConnect(SqlConnection con)
        {
            if (con.State == System.Data.ConnectionState.Open)
            {
                con.Close();
            }
        }
    }
}
