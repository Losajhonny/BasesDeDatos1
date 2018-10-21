using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos
{
    public class Mensaje
    {
        /**
         * Este metodo crea el mensaje cuando no existe de lo contrario busca
         * el mensaje y retorna el codigo del mensaje
         * */
        public static int crear_mensaje(string asunto, string texto)
        {
            //int codMsg = obtenerMsg(asunto, mensaje);
            //if (codMsg == -1)
            //{
                crear_mensajes(asunto, texto);
                int codMsg = obtener_mensaje(asunto, texto);
            //}
            return codMsg;
        }

        public static void crear_mensajes(string asunto, string texto)
        {
            SqlConnection conn = Conexion.connect();
            try
            {
                Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("crear_mensaje", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                
                SqlParameter pasunto = new SqlParameter("@asunto", System.Data.SqlDbType.VarChar);
                pasunto.Size = 50;
                pasunto.Value = asunto;

                SqlParameter ptexto = new SqlParameter("@texto", System.Data.SqlDbType.VarChar);
                ptexto.Size = 256;
                ptexto.Value = texto;

                cmd.Parameters.Add(pasunto);
                cmd.Parameters.Add(ptexto);
                cmd.ExecuteScalar();
            }
            catch (Exception ex) { }
            Conexion.closeConnect(conn);
        }

        public static int obtener_mensaje(string asunto, string texto)
        {
            SqlConnection conn = Conexion.connect();
            try
            {
                Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("Select dbo.obtener_mensaje(@asunto, @texto)", conn);

                SqlParameter pasunto = new SqlParameter("@asunto", System.Data.SqlDbType.VarChar);
                pasunto.Size = 50;
                pasunto.Value = asunto;

                SqlParameter ptexto = new SqlParameter("@texto", System.Data.SqlDbType.VarChar);
                ptexto.Size = 256;
                ptexto.Value = texto;

                cmd.Parameters.Add(pasunto);
                cmd.Parameters.Add(ptexto);

                int codigo = Convert.ToInt32(cmd.ExecuteScalar());
                Conexion.closeConnect(conn);
                return codigo;
            }
            catch (Exception ex) { }
            Conexion.closeConnect(conn);
            return -1;
        }

        public static void asignar_mensaje(string tipo, string fecha, int codmsg, int codcarpeta, 
            string quienenvia, string lista)
        {
            SqlConnection conn = Conexion.connect();
            try
            {
                Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("asignar_msg", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter ptipo = new SqlParameter("@tipo", System.Data.SqlDbType.VarChar);
                ptipo.Value = tipo;
                ptipo.Size = 30;

                SqlParameter pfecha = new SqlParameter("@fecha", System.Data.SqlDbType.DateTime);
                pfecha.Value = fecha;

                SqlParameter pcod_msg = new SqlParameter("@cod_msg", System.Data.SqlDbType.Int);
                pcod_msg.Value = codmsg;

                SqlParameter pcod_carpeta = new SqlParameter("@cod_carpeta", System.Data.SqlDbType.Int);
                pcod_carpeta.Value = codcarpeta;

                SqlParameter pcuenta = new SqlParameter("@cuenta", System.Data.SqlDbType.VarChar);
                pcuenta.Value = quienenvia;
                pcuenta.Size = 50;

                SqlParameter plista = new SqlParameter("@lista", System.Data.SqlDbType.VarChar);
                if (lista != null)
                {
                    plista.Value = lista;
                    plista.Size = 256;
                }
                else
                {
                    plista.Value = DBNull.Value;
                }

                cmd.Parameters.Add(ptipo);
                cmd.Parameters.Add(pfecha);
                cmd.Parameters.Add(pcod_msg);
                cmd.Parameters.Add(pcod_carpeta);
                cmd.Parameters.Add(pcuenta);
                cmd.Parameters.Add(plista);

                cmd.ExecuteScalar();
            }
            catch (Exception ex) { }
        }

        public static void asignar_archivo(int mensaje, string ruta)
        {
            SqlConnection conn = Conexion.connect();
            try
            {
                Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("asignar_archivo", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter pruta = new SqlParameter("@ruta", System.Data.SqlDbType.VarChar);
                pruta.Value = ruta;
                pruta.Size = 50;

                SqlParameter pcod = new SqlParameter("@mensaje", System.Data.SqlDbType.Int);
                pcod.Value = mensaje;

                cmd.Parameters.Add(pruta);
                cmd.Parameters.Add(pcod);
                cmd.ExecuteScalar();

            }catch(Exception ex){  }
            Conexion.closeConnect(conn);
        }

        public static void cambiarEstado(int estado, int codigo)
        {
            SqlConnection conn = Conexion.connect();
            try
            {
                Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("actualizar_estado", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter pestado = new SqlParameter("@estado", System.Data.SqlDbType.Int);
                pestado.Value = estado;

                SqlParameter pcodigo = new SqlParameter("@codigo", System.Data.SqlDbType.Int);
                pcodigo.Value = codigo;
                cmd.Parameters.Add(pestado);
                cmd.Parameters.Add(pcodigo);

                cmd.ExecuteScalar();
            }
            catch (Exception ex) { }
            finally { Conexion.closeConnect(conn); }
        }

        public static void mover_aEliminar(string usuario, int codigo)
        {
            int carpetaEliminados = Carpeta.obtener_carpeta("eliminados", usuario, null, 0);
            SqlConnection conn = Conexion.connect();
            try
            {
                Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("actualizar_carpeta", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter pcarpeta = new SqlParameter("@carpeta", System.Data.SqlDbType.Int);
                pcarpeta.Value = carpetaEliminados;

                SqlParameter pcodigo = new SqlParameter("@codigo", System.Data.SqlDbType.Int);
                pcodigo.Value = codigo;

                cmd.Parameters.Add(pcarpeta);
                cmd.Parameters.Add(pcodigo);

                cmd.ExecuteScalar();
            }
            catch (Exception ex) { }
            finally { Conexion.closeConnect(conn); }
        }

        public static void eliminar_msg(int codigo)
        {
            SqlConnection conn = Conexion.connect();
            try
            {
                Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("eliminar_msg", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter pcodigo = new SqlParameter("@codigo", System.Data.SqlDbType.Int);
                pcodigo.Value = codigo;
                cmd.Parameters.Add(pcodigo);

                cmd.ExecuteScalar();
            }
            catch (Exception ex) { }
            finally { Conexion.closeConnect(conn); }
        }

        public static List<string> getArchivos(int codigo)
        {
            SqlConnection conn = Conexion.connect();
            try
            {
                Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("SELECT ruta FROM ARCHIVO WHERE MENSAJE_codigo = @codigo", conn);
                SqlParameter pcodigo = new SqlParameter("@codigo", System.Data.SqlDbType.Int);
                pcodigo.Value = codigo;

                cmd.Parameters.Add(pcodigo);
                SqlDataReader reader = cmd.ExecuteReader();
                List<string> lista = new List<string>();
                while (reader.Read())
                {
                    lista.Add(reader.GetString(0));
                }
                return lista;
            }
            catch (Exception ex) { }
            finally { Conexion.closeConnect(conn); }
            return null;
        }
    }
}
