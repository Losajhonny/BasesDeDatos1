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
                SqlCommand cmd = new SqlCommand("SELECT dbo.existe_usuario(@usuario)", conn);

                SqlParameter usr = new SqlParameter("@usuario", System.Data.SqlDbType.VarChar);
                usr.Value = user;
                usr.Size = 50;

                cmd.Parameters.Add(usr);
                bool exist = Convert.ToBoolean(cmd.ExecuteScalar());
                Conexion.closeConnect(conn);
                return exist;
            }
            catch (Exception ex) { }
            Conexion.closeConnect(conn);
            return false;
        }

        public static bool existe_correo(string user, string dominio)
        {
            SqlConnection conn = Conexion.connect();
            try
            {
                Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("SELECT dbo.existe_correo(@usuario, @dominio)", conn);

                SqlParameter usr = new SqlParameter("@usuario", System.Data.SqlDbType.VarChar);
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
        
        public static string loguear(string usuario, string password)
        {
            char[] delimit = { '@' };
            char[] delimit2 = { '.' };

            string[] valores = usuario.Split(delimit, StringSplitOptions.RemoveEmptyEntries);
            SqlConnection conn = Conexion.connect();
            try
            {
                string[] val = valores[1].Split(delimit2, StringSplitOptions.RemoveEmptyEntries);
                Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("SELECT dbo.loguear(@usuario, @dominio, @pass)", conn);

                SqlParameter user = new SqlParameter("@usuario", System.Data.SqlDbType.VarChar);
                user.Value = valores[0];
                user.Size = 50;

                SqlParameter dominio = new SqlParameter("@dominio", System.Data.SqlDbType.VarChar);
                dominio.Value = val[0];
                dominio.Size = 50;

                SqlParameter pass = new SqlParameter("@pass", System.Data.SqlDbType.VarChar);
                pass.Value = password;
                pass.Size = 50;

                cmd.Parameters.Add(user);
                cmd.Parameters.Add(dominio);
                cmd.Parameters.Add(pass);

                bool estado = Convert.ToBoolean(cmd.ExecuteScalar());
                if (estado)
                {
                    Conexion.closeConnect(conn);
                    return valores[0];
                }
            }
            catch (Exception ex) { }
            Conexion.closeConnect(conn);
            return null;
        }

        public static List<string[]> vista_correos(int carpeta)
        {
            SqlConnection conn = Conexion.connect();
            try
            {
                Conexion.openConnect(conn);
                string query = "SELECT S.codigo, S.estado, CU.nombre, M.asunto, S.fecha, " + 
                "S.MENSAJE_codigo FROM MSG S, CARPETA C, MENSAJE M, CUENTA CU " +
                "WHERE S.CARPETA_codigo = C.codigo " +
                "AND S.CARPETA_codigo = @carpeta " +
                "AND S.MENSAJE_codigo = M.codigo " +
                "AND S.CUENTA_ident = CU.ident";
                /*string query = "SELECT S.estado, CU.nombre, M.asunto, S.fecha " +
                    "FROM MSG S, CARPETA C, MENSAJE M, CUENTA CU " +
                    "WHERE S.CARPETA_codigo = C.codigo " + 
                    "AND S.CARPETA_codigo = @carpeta " + 
                    "AND S.MENSAJE_codigo = M.codigo " +
                    "AND S.CUENTA_ident = CU.ident";*/
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlParameter pcarpeta = new SqlParameter("@carpeta", System.Data.SqlDbType.Int);
                pcarpeta.Value = carpeta;
                cmd.Parameters.Add(pcarpeta);

                SqlDataReader reader = cmd.ExecuteReader();
                List<string[]> lista = new List<string[]>();
                while (reader.Read())
                {
                    string[] info = new string[7];
                    info[0] = reader.GetInt32(0).ToString(); //S.codigo
                    info[1] = reader.GetInt32(1).ToString(); //S.estado
                    info[2] = reader.GetString(2).ToString(); //CU.nombre
                    info[3] = reader.GetString(3).ToString(); //M.asunto
                    info[4] = reader.GetDateTime(4).ToString(); //S.fecha
                    info[5] = reader.GetInt32(5).ToString(); //S.MENSAJE_codigo
                    lista.Add(info);
                }
                reader.Close();
                Conexion.closeConnect(conn);
                return lista;
            }
            catch (Exception ex) { }
            finally { Conexion.closeConnect(conn); }
            return null;
        }

        public static string[] vista_correo(int codigo)
        {
            SqlConnection conn = Conexion.connect();
            try
            {
                Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("SELECT S.codigo, S.fecha, S.estado, " + 
                    "S.tipo, S.MENSAJE_codigo, S.lista, M.asunto, M.texto, CU.nombre FROM MSG S, CARPETA C, " +
                    "MENSAJE M, CUENTA CU WHERE S.CARPETA_codigo = C.codigo " + 
                    "AND S.MENSAJE_codigo = M.codigo AND S.CUENTA_ident = CU.ident " + 
                    "AND S.codigo = @codigo", conn);
                SqlParameter pcodigo = new SqlParameter("@codigo", System.Data.SqlDbType.Int);
                pcodigo.Value = codigo;
                cmd.Parameters.Add(pcodigo);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    string[] info = new string[9];
                    info[0] = reader.GetInt32(0).ToString(); //s.codigo
                    info[1] = reader.GetDateTime(1).ToString(); //s.fecha
                    info[2] = reader.GetInt32(2).ToString(); //s.estado
                    info[3] = reader.GetString(3).ToString(); //s.tipo
                    info[4] = reader.GetInt32(4).ToString(); //s.MENSAJE_codigo
                    info[5] = reader.GetString(5).ToString(); //s.lista
                    
                    info[6] = reader.GetString(6).ToString(); //m.asunto
                    info[7] = reader.GetString(7).ToString(); //m.texto

                    info[8] = reader.GetString(8).ToString(); //cu.nombre
                    return info;
                }
            }
            catch (Exception ex) { }
            finally { Conexion.closeConnect(conn); }
            return null;
        }
    }
}
