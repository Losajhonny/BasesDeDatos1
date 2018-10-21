using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos
{
    public class Usuario
    {
        public static bool existe_usuario(string user)
        {
            SqlConnection conn = Conexion.connect();
            try
            {
                Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("SELECT dbo.verificar_usuario(@user)", conn);

                SqlParameter usr = new SqlParameter("@user", System.Data.SqlDbType.VarChar);
                usr.Value = user;
                usr.Size = 50;

                cmd.Parameters.Add(usr);
                bool exist = Convert.ToBoolean(cmd.ExecuteScalar());
                return exist;
            }
            catch (Exception ex) { }
            Conexion.closeConnect(conn);
            return false;
        }

        public static bool correo_existe(string user, string dominio)
        {
            SqlConnection conn = Conexion.connect();
            try
            {
                Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("SELECT dbo.existe_usuario(@user, @dominio)", conn);

                SqlParameter usr = new SqlParameter("@user", System.Data.SqlDbType.VarChar);
                usr.Value = user;
                usr.Size = 50;

                SqlParameter dom = new SqlParameter("@dominio", System.Data.SqlDbType.VarChar);
                dom.Value = dominio;
                dom.Size = 50;

                cmd.Parameters.Add(usr);
                cmd.Parameters.Add(dom);
                bool exist = Convert.ToBoolean(cmd.ExecuteScalar());
                Conexion.closeConnect(conn);
                return exist;
            }
            catch (Exception ex) { }
            Conexion.closeConnect(conn);
            return false;
        }

        public static void crear_usuario(string nombre, string empresa, string usuario, string dominio, string password)
        {
            SqlConnection conn = Conexion.connect();
            try
            {
                Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("crear_usuario", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter pident = new SqlParameter("@ident", System.Data.SqlDbType.VarChar);
                pident.Value = usuario;
                pident.Size = 50;

                SqlParameter pnombre = new SqlParameter("@nombre", System.Data.SqlDbType.VarChar);
                pnombre.Value = nombre;
                pnombre.Size = 100;

                SqlParameter pempresa = new SqlParameter("@empresa", System.Data.SqlDbType.VarChar);
                pempresa.Value = empresa;
                pempresa.Size = 50;

                SqlParameter pdominio = new SqlParameter("@dominio", System.Data.SqlDbType.VarChar);
                pdominio.Value = dominio;
                pdominio.Size = 50;

                SqlParameter ppass = new SqlParameter("@pass", System.Data.SqlDbType.VarChar);
                ppass.Value = password;
                ppass.Size = 50;

                cmd.Parameters.Add(pident);
                cmd.Parameters.Add(pnombre);
                cmd.Parameters.Add(pempresa);
                cmd.Parameters.Add(pdominio);
                cmd.Parameters.Add(ppass);

                cmd.ExecuteScalar();
            }
            catch (Exception ex) { }
            Conexion.closeConnect(conn);
        }

        public static int buscar_carpeta(string nombre, string usuario, string padre, int nivel)
        {
            SqlConnection conn = Conexion.connect();
            try
            {
                Conexion.openConnect(conn);

                SqlCommand cmd = new SqlCommand("Select dbo.buscar_carpeta(@nombre, @usuario, @padre, @nivel)", conn);

                SqlParameter pnombre = new SqlParameter("@nombre", System.Data.SqlDbType.VarChar);
                pnombre.Value = nombre;
                pnombre.Size = 50;

                SqlParameter pusuario = new SqlParameter("@usuario", System.Data.SqlDbType.VarChar);
                pusuario.Value = usuario;
                pusuario.Size = 50;

                SqlParameter ppadre = new SqlParameter("@padre", System.Data.SqlDbType.VarChar);
                ppadre.Value = padre;
                ppadre.Size = 50;

                SqlParameter pnivel = new SqlParameter("@nivel", System.Data.SqlDbType.Int);
                pnivel.Value = nivel;

                cmd.Parameters.Add(pnombre);
                cmd.Parameters.Add(pusuario);
                cmd.Parameters.Add(ppadre);
                cmd.Parameters.Add(pnivel);

                int cod = Convert.ToInt32(cmd.ExecuteScalar());
                return cod;
            }
            catch (Exception ex) { }
            Conexion.closeConnect(conn);
            return -1;
        }

        public static string logear(string usuario, string password)
        {
            char[] delimit = { '@' };
            char[] delimit2 = { '.' };

            string[] valores = usuario.Split(delimit, StringSplitOptions.RemoveEmptyEntries);
            SqlConnection conn = Conexion.connect();
            try
            {
                string[] val = valores[1].Split(delimit2, StringSplitOptions.RemoveEmptyEntries);
                Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("SELECT dbo.logear(@user, @dominio, @password)", conn);

                SqlParameter user = new SqlParameter("@user", System.Data.SqlDbType.VarChar);
                user.Value = valores[0];
                user.Size = 50;

                SqlParameter dominio = new SqlParameter("@dominio", System.Data.SqlDbType.VarChar);
                dominio.Value = val[0];
                dominio.Size = 50;

                SqlParameter pass = new SqlParameter("@password", System.Data.SqlDbType.VarChar);
                pass.Value = password;
                pass.Size = 50;

                cmd.Parameters.Add(user);
                cmd.Parameters.Add(dominio);
                cmd.Parameters.Add(pass);

                int estado = Convert.ToInt32(cmd.ExecuteScalar());
                if (estado == 1)
                {
                    return valores[0];
                }
            }
            catch (Exception ex) { }
            Conexion.closeConnect(conn);
            return null;
        }
    }
}
