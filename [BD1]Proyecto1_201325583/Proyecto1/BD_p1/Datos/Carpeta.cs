using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos
{
    public class Carpeta
    {
        public static int obtener_carpeta(string nombre, string usuario, string padre, int nivel)
        {
            SqlConnection conn = Conexion.connect();
            try
            {
                Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("Select dbo.obtener_carpeta(@padre, @nivel, @nombre, @usuario)", conn);

                SqlParameter pnombre = new SqlParameter("@nombre", System.Data.SqlDbType.VarChar);
                pnombre.Value = nombre;
                pnombre.Size = 50;

                SqlParameter pusuario = new SqlParameter("@usuario", System.Data.SqlDbType.VarChar);
                pusuario.Value = usuario;
                pusuario.Size = 50;

                SqlParameter ppadre = new SqlParameter("@padre", System.Data.SqlDbType.VarChar);
                if (padre != null)
                {
                    ppadre.Value = padre;
                    ppadre.Size = 50;
                }
                else
                {
                    ppadre.Value = DBNull.Value;
                }

                SqlParameter pnivel = new SqlParameter("@nivel", System.Data.SqlDbType.Int);
                pnivel.Value = nivel;

                cmd.Parameters.Add(ppadre);
                cmd.Parameters.Add(pnivel);
                cmd.Parameters.Add(pnombre);
                cmd.Parameters.Add(pusuario);

                int cod = Convert.ToInt32(cmd.ExecuteScalar());
                Conexion.closeConnect(conn);
                return cod;
            }
            catch (Exception ex) { }
            Conexion.closeConnect(conn);
            return -1;
        }

        public static void crear_carpeta(string nombre, string tipo, string usuario, string padre, int nivel)
        {
            SqlConnection conn = Conexion.connect();
            try
            {
                Conexion.openConnect(conn);

                SqlCommand cmd = new SqlCommand("crear_carpeta", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter pnombre = new SqlParameter("@nombre", System.Data.SqlDbType.VarChar);
                pnombre.Value = nombre;
                pnombre.Size = 50;

                SqlParameter ptipo = new SqlParameter("@tipo", System.Data.SqlDbType.VarChar);
                ptipo.Value = nombre;
                ptipo.Size = 50;

                SqlParameter pusuario = new SqlParameter("@usuario", System.Data.SqlDbType.VarChar);
                pusuario.Value = usuario;
                pusuario.Size = 50;

                SqlParameter ppadre = new SqlParameter("@padre", System.Data.SqlDbType.VarChar);
                ppadre.Value = padre;
                ppadre.Size = 50;

                SqlParameter pnivel = new SqlParameter("@nivel", System.Data.SqlDbType.Int);
                pnivel.Value = nivel;

                cmd.Parameters.Add(pnombre);
                cmd.Parameters.Add(ptipo);
                cmd.Parameters.Add(pusuario);
                cmd.Parameters.Add(ppadre);
                cmd.Parameters.Add(pnivel);

                cmd.ExecuteScalar();
            }
            catch (Exception ex) { }
            Conexion.closeConnect(conn);
        }
    }
}
