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
        public static int crear_mensaje(string asunto, string mensaje)
        {
            //int codMsg = obtenerMsg(asunto, mensaje);
            //if (codMsg == -1)
            //{
                crearMsg(asunto, mensaje);
                int codMsg = obtenerMsg(asunto, mensaje);
            //}
            return codMsg;
        }

        public static void crearMsg(string asunto, string mensaje)
        {
            SqlConnection conn = Conexion.connect();
            try
            {
                Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("crear_mensaje", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter ptexto = new SqlParameter("@texto", System.Data.SqlDbType.VarChar);
                ptexto.Size = 256;
                ptexto.Value = mensaje;

                SqlParameter pasunto = new SqlParameter("@asunto", System.Data.SqlDbType.VarChar);
                pasunto.Size = 50;
                pasunto.Value = asunto;

                cmd.Parameters.Add(ptexto);
                cmd.Parameters.Add(pasunto);
                cmd.ExecuteScalar();
            }
            catch (Exception ex) { }
            Conexion.closeConnect(conn);
        }

        public static int obtenerMsg(string asunto, string mensaje)
        {
            SqlConnection conn = Conexion.connect();
            try
            {
                Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("Select dbo.obtener_mensaje(@texto, @asunto)", conn);

                SqlParameter ptexto = new SqlParameter("@texto", System.Data.SqlDbType.VarChar);
                ptexto.Size = 256;
                ptexto.Value = mensaje;

                SqlParameter pasunto = new SqlParameter("@asunto", System.Data.SqlDbType.VarChar);
                pasunto.Size = 50;
                pasunto.Value = asunto;

                cmd.Parameters.Add(ptexto);
                cmd.Parameters.Add(pasunto);

                int codigo = Convert.ToInt32(cmd.ExecuteScalar());
                Conexion.closeConnect(conn);
                return codigo;
            }
            catch (Exception ex) { }
            Conexion.closeConnect(conn);
            return -1;
        }

        public static void asignar_mensaje(string tipo, string fecha, int codmsg, int codcarpeta, string quienenvia)
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

                if (quienenvia != null)
                {
                    pcuenta.Value = quienenvia;
                    pcuenta.Size = 50;
                }
                else
                {
                    pcuenta.Value = DBNull.Value;
                }

                cmd.Parameters.Add(ptipo);
                cmd.Parameters.Add(pfecha);
                cmd.Parameters.Add(pcod_msg);
                cmd.Parameters.Add(pcod_carpeta);
                cmd.Parameters.Add(pcuenta);

                cmd.ExecuteScalar();
            }
            catch (Exception ex) { }
        }

        public static void asignar_archivo(int codmsg, string ruta)
        {
            SqlConnection conn = Conexion.connect();
            try
            {
                Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("asignar_archivos", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                SqlParameter pruta = new SqlParameter("@ruta", System.Data.SqlDbType.VarChar);
                pruta.Value = ruta;
                pruta.Size = 50;

                SqlParameter pcod = new SqlParameter("@codmsg", System.Data.SqlDbType.Int);
                pcod.Value = codmsg;

                cmd.Parameters.Add(pruta);
                cmd.Parameters.Add(pcod);
                cmd.ExecuteScalar();

            }catch(Exception ex){  }
            Conexion.closeConnect(conn);
        }
    }
}
