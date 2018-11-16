using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos
{
    public class Equipo
    {
        public static DataTable vista_confede_y_equipo()
        {
            DataTable dt = new DataTable();
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("SELECT * FROM CONFEDE_Y_EQUIPOS", conn);
                dt.Load(cmd.ExecuteReader());
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return dt;
        }

        public static DataSet vista_confederacion()
        {
            DataSet ds = new DataSet();
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("SELECT * FROM VISTA_CONFEDERACION", conn);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(ds);
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return ds;
        }

        public static DataTable vista_posicion_general()
        {
            DataTable dt = new DataTable();
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("SELECT * FROM POSICION_GENERAL ORDER BY Puntos DESC", conn);
                dt.Load(cmd.ExecuteReader());
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return dt;
        }
        
        public static DataSet vista_equipo()
        {
            DataSet ds = new DataSet();
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("SELECT * FROM VISTA_EQUIPOS", conn);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(ds);
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return ds;
        }

        public static bool eliminar_equipo(string nombre)
        {
            bool correcto = false;
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("ELIMINAR_EQUIPO", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter pnombre = new SqlParameter("@equipo", SqlDbType.VarChar);
                pnombre.Size = 50;
                pnombre.Value = nombre;

                cmd.Parameters.Add(pnombre);
                cmd.ExecuteScalar();
                correcto = true;
            }
            catch (Exception ex) { correcto = false; }
            finally { Conexion.Conexion.closeConnect(conn); }
            return correcto;
        }

        public static int buscar_equipo(string equipo)
        {
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlParameter pequipo = new SqlParameter("@equipo", equipo);
                pequipo.Size = 50;
                pequipo.SqlDbType = SqlDbType.VarChar;

                SqlCommand cmd = new SqlCommand("SELECT dbo.OBTENER_CODIGO_EQUIPO (@equipo)", conn);
                cmd.Parameters.Add(pequipo);

                return Convert.ToInt32(cmd.ExecuteScalar());
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return -1;
        }

        public static bool modificar_equipo(int codequipo, string equipo, string confede)
        {
            bool correcto = false;
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("MODIFICAR_EQUIPO", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter pcodequipo = new SqlParameter("@codequipo", SqlDbType.Int);
                pcodequipo.Value = codequipo;

                SqlParameter pequipo = new SqlParameter("@equipo", SqlDbType.VarChar);
                pequipo.Size = 50;
                pequipo.Value = equipo;

                SqlParameter pconfede = new SqlParameter("@confede", SqlDbType.VarChar);
                pconfede.Size = 50;
                pconfede.Value = confede;

                cmd.Parameters.Add(pcodequipo);
                cmd.Parameters.Add(pequipo);
                cmd.Parameters.Add(pconfede);

                cmd.ExecuteScalar();
                correcto = true;
            }
            catch (Exception ex) { correcto = false; }
            finally { Conexion.Conexion.closeConnect(conn); }
            return correcto;
        }

        public static bool insertar_equipo(string equipo, string confede)
        {
            bool correcto = false;
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlParameter pequipo = new SqlParameter("@equipo", SqlDbType.VarChar);
                pequipo.Size = 50;
                pequipo.Value = equipo;

                SqlParameter pconfede = new SqlParameter("@confederacion", SqlDbType.VarChar);
                pconfede.Size = 50;
                pconfede.Value = confede;

                SqlCommand cmd = new SqlCommand("INSERTAR_EQUIPO", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(pequipo);
                cmd.Parameters.Add(pconfede);

                cmd.ExecuteScalar();
                correcto = true;
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return correcto;
        }

        public static void cargar_equipos(string equipo, string confede, string grupo)
        {
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);

                SqlParameter pequipo = new SqlParameter("@equipo", equipo);
                pequipo.Size = 50;
                pequipo.SqlDbType = SqlDbType.VarChar;

                SqlParameter pconfede = new SqlParameter("@confede", confede);
                pconfede.Size = 50;
                pconfede.SqlDbType = SqlDbType.VarChar;

                SqlParameter pgrupo = new SqlParameter("@grupo", grupo);
                pgrupo.Size = 50;
                pgrupo.SqlDbType = SqlDbType.VarChar;

                SqlCommand cmd = new SqlCommand("CARGAR_EQUIPOS", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(pequipo);
                cmd.Parameters.Add(pconfede);
                cmd.Parameters.Add(pgrupo);

                cmd.ExecuteScalar();
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
        }

        public static DataTable vista_resultados_equipo(string equipo)
        {
            DataTable dt = new DataTable();
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlParameter pequipo = new SqlParameter("@equipo", equipo);
                pequipo.SqlDbType = SqlDbType.VarChar;
                pequipo.Size = 50;

                SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.VISTA_RESULTADO_EQUIPO(@equipo)", conn);
                cmd.Parameters.Add(pequipo);
                dt.Load(cmd.ExecuteReader());
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return dt;
        }
    }
}
