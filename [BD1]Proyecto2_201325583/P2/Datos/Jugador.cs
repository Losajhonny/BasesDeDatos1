using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos
{
    public class Jugador
    {
        public static bool insertar_jugador(int camisola, string posicion, string nombre, 
            string fecha, int estatura, int peso, int goles, string equipo)
        {

            /*@nocamisola INTEGER, @posicion VARCHAR(5),
            @nombre VARCHAR(50), @fecha DATE, 
            @estatura NUMERIC(10,2), @peso NUMERIC(10,2), 
            @goles INTEGER , @seleccion VARCHAR(50)*/
            bool correcto = false;
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);

                SqlParameter pcamisola = new SqlParameter("@nocamisola", camisola);
                pcamisola.SqlDbType = System.Data.SqlDbType.Int;

                SqlParameter pposicion = new SqlParameter("@posicion", posicion);
                pposicion.SqlDbType = System.Data.SqlDbType.VarChar;
                pposicion.Size = 5;

                SqlParameter pnombre = new SqlParameter("@nombre", nombre);
                pnombre.SqlDbType = System.Data.SqlDbType.VarChar;
                pnombre.Size = 50;

                SqlParameter pfecha = new SqlParameter("@fecha", System.Data.SqlDbType.Date);
                if (fecha != null) { pfecha.Value = fecha; } else { pfecha.Value = DBNull.Value; }

                SqlParameter pestatura = new SqlParameter("@estatura", estatura);
                pestatura.SqlDbType = System.Data.SqlDbType.Decimal;

                SqlParameter ppeso = new SqlParameter("@peso", peso);
                ppeso.SqlDbType = System.Data.SqlDbType.Decimal;

                SqlParameter pgoles = new SqlParameter("@goles", goles);
                pgoles.SqlDbType = System.Data.SqlDbType.Int;

                SqlParameter pequipo = new SqlParameter("@equipo", equipo);
                pequipo.SqlDbType = System.Data.SqlDbType.VarChar;
                pequipo.Size = 50;

                SqlCommand cmd = new SqlCommand("INSERTAR_JUGADOR", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(pcamisola);
                cmd.Parameters.Add(pposicion);
                cmd.Parameters.Add(pnombre);
                cmd.Parameters.Add(pfecha);
                cmd.Parameters.Add(pestatura);
                cmd.Parameters.Add(ppeso);
                cmd.Parameters.Add(pgoles);
                cmd.Parameters.Add(pequipo);

                cmd.ExecuteScalar();
                correcto = true;
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return correcto;
        }

        public static bool insertar_jugador_carga(int camisola, string posicion, string nombre,
            DateTime fecha, int estatura, int peso, int goles, string equipo)
        {

            /*@nocamisola INTEGER, @posicion VARCHAR(5),
            @nombre VARCHAR(50), @fecha DATE, 
            @estatura NUMERIC(10,2), @peso NUMERIC(10,2), 
            @goles INTEGER , @seleccion VARCHAR(50)*/
            bool correcto = false;
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);

                SqlParameter pcamisola = new SqlParameter("@nocamisola", camisola);
                pcamisola.SqlDbType = System.Data.SqlDbType.Int;

                SqlParameter pposicion = new SqlParameter("@posicion", posicion);
                pposicion.SqlDbType = System.Data.SqlDbType.VarChar;
                pposicion.Size = 5;

                SqlParameter pnombre = new SqlParameter("@nombre", nombre);
                pnombre.SqlDbType = System.Data.SqlDbType.VarChar;
                pnombre.Size = 50;

                SqlParameter pfecha = new SqlParameter("@fecha", System.Data.SqlDbType.DateTime);
                if (fecha != null) { pfecha.Value = fecha; } else { pfecha.Value = DBNull.Value; }

                SqlParameter pestatura = new SqlParameter("@estatura", estatura);
                pestatura.SqlDbType = System.Data.SqlDbType.Decimal;

                SqlParameter ppeso = new SqlParameter("@peso", peso);
                ppeso.SqlDbType = System.Data.SqlDbType.Decimal;

                SqlParameter pgoles = new SqlParameter("@goles", goles);
                pgoles.SqlDbType = System.Data.SqlDbType.Int;

                SqlParameter pequipo = new SqlParameter("@equipo", equipo);
                pequipo.SqlDbType = System.Data.SqlDbType.VarChar;
                pequipo.Size = 50;

                SqlCommand cmd = new SqlCommand("INSERTAR_JUGADOR_CARGA", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(pcamisola);
                cmd.Parameters.Add(pposicion);
                cmd.Parameters.Add(pnombre);
                cmd.Parameters.Add(pfecha);
                cmd.Parameters.Add(pestatura);
                cmd.Parameters.Add(ppeso);
                cmd.Parameters.Add(pgoles);
                cmd.Parameters.Add(pequipo);

                cmd.ExecuteScalar();
                correcto = true;
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return correcto;
        }

        public static DataTable vista_jugador_equipo(string equipo)
        {
            DataTable dt = new DataTable();
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlParameter pequipo = new SqlParameter("@equipo", equipo);
                pequipo.SqlDbType = SqlDbType.VarChar;
                pequipo.Size = 50;

                SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.JUGADORES_POR_EQUIPO(@equipo)", conn);
                cmd.Parameters.Add(pequipo);
                dt.Load(cmd.ExecuteReader());
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return dt;
        }

        public static DataTable vista_jugador_equipo_camisola(string equipo)
        {
            DataTable dt = new DataTable();
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlParameter pequipo = new SqlParameter("@equipo", equipo);
                pequipo.SqlDbType = SqlDbType.VarChar;
                pequipo.Size = 50;

                SqlCommand cmd = new SqlCommand("SELECT NoCamisola FROM dbo.JUGADORES_POR_EQUIPO(@equipo)", conn);
                cmd.Parameters.Add(pequipo);
                dt.Load(cmd.ExecuteReader());
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return dt;
        }

        public static DataSet vista_jugador_equipo2(string equipo)
        {
            DataSet ds = new DataSet();
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlParameter pequipo = new SqlParameter("@equipo", equipo);
                pequipo.SqlDbType = SqlDbType.VarChar;
                pequipo.Size = 50;

                SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.JUGADORES_POR_EQUIPO_ID(@equipo)", conn);
                cmd.Parameters.Add(pequipo);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(ds);
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return ds;
        }

        public static DataTable vista_goleadores()
        {
            DataTable dt = new DataTable();
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("SELECT * FROM LISTA_GOLEADORES", conn);
                dt.Load(cmd.ExecuteReader());
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return dt;
        }

        public static void actualizar_goles(string equipo, int camisola)
        {
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlParameter pcamisola = new SqlParameter("@nocamisola", camisola);
                pcamisola.SqlDbType = System.Data.SqlDbType.Int;

                SqlParameter pequipo = new SqlParameter("@equipo", equipo);
                pequipo.SqlDbType = System.Data.SqlDbType.VarChar;
                pequipo.Size = 50;

                SqlCommand cmd = new SqlCommand("AUMENTADO_GOLES", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(pequipo);
                cmd.Parameters.Add(pcamisola);

                cmd.ExecuteScalar();
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
        }
    }
}
