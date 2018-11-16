using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos
{
    public class Partido
    {
        public static void cargar_partidos(DateTime fecha, DateTime hora, string sede, string[] arbitroc,
            string[] arbitro1, string[] arbitro2, string equipo1, string equipo2)
        {
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);

                SqlParameter pfecha = new SqlParameter("@fecha", fecha);
                pfecha.SqlDbType = System.Data.SqlDbType.DateTime;

                SqlParameter phora = new SqlParameter("@hora", hora);
                phora.SqlDbType = System.Data.SqlDbType.DateTime;

                SqlParameter psede = new SqlParameter("@sede", sede);
                psede.SqlDbType = System.Data.SqlDbType.VarChar;
                psede.Size = 50;

                SqlParameter parbitroc = new SqlParameter("@arbitroc", arbitroc[0]);
                parbitroc.SqlDbType = System.Data.SqlDbType.VarChar;
                parbitroc.Size = 50;

                SqlParameter prolc = new SqlParameter("@rolc", arbitroc[1]);
                prolc.SqlDbType = System.Data.SqlDbType.VarChar;
                prolc.Size = 50;

                SqlParameter parbitro1 = new SqlParameter("@arbitro1", arbitro1[0]);
                parbitro1.SqlDbType = System.Data.SqlDbType.VarChar;
                parbitro1.Size = 50;

                SqlParameter prol1 = new SqlParameter("@rol1", arbitro1[1]);
                prol1.SqlDbType = System.Data.SqlDbType.VarChar;
                prol1.Size = 50;

                SqlParameter parbitro2 = new SqlParameter("@arbitro2", arbitro2[0]);
                parbitro2.SqlDbType = System.Data.SqlDbType.VarChar;
                parbitro2.Size = 50;

                SqlParameter prol2 = new SqlParameter("@rol2", arbitro2[1]);
                prol2.SqlDbType = System.Data.SqlDbType.VarChar;
                prol2.Size = 50;

                SqlParameter pequipo1 = new SqlParameter("@equipo1", equipo1);
                pequipo1.SqlDbType = System.Data.SqlDbType.VarChar;
                pequipo1.Size = 50;

                SqlParameter pequipo2 = new SqlParameter("@equipo2", equipo2);
                pequipo2.SqlDbType = System.Data.SqlDbType.VarChar;
                pequipo2.Size = 50;

                SqlCommand cmd = new SqlCommand("CARGAR_CATALOGO", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(pfecha);
                cmd.Parameters.Add(phora);
                cmd.Parameters.Add(psede);
                cmd.Parameters.Add(parbitroc);
                cmd.Parameters.Add(prolc);
                cmd.Parameters.Add(parbitro1);
                cmd.Parameters.Add(prol1);
                cmd.Parameters.Add(parbitro2);
                cmd.Parameters.Add(prol2);
                cmd.Parameters.Add(pequipo1);
                cmd.Parameters.Add(pequipo2);

                cmd.ExecuteScalar();
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
        }

        public static void modificar_marcador(DateTime fecha, DateTime hora, int marcador1, int marcador2, string equipo1, string equipo2){
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);

                SqlParameter pfecha = new SqlParameter("@fecha", fecha);
                pfecha.SqlDbType = System.Data.SqlDbType.DateTime;

                SqlParameter phora = new SqlParameter("@hora", hora);
                phora.SqlDbType = System.Data.SqlDbType.DateTime;

                SqlParameter pmarcador1 = new SqlParameter("@marcador1", marcador1);
                pmarcador1.SqlDbType = System.Data.SqlDbType.Int;

                SqlParameter pmarcador2 = new SqlParameter("@marcador2", marcador2);
                pmarcador2.SqlDbType = System.Data.SqlDbType.Int;

                SqlParameter pequipo1 = new SqlParameter("@equipo1", equipo1);
                pequipo1.SqlDbType = System.Data.SqlDbType.VarChar;
                pequipo1.Size = 50;

                SqlParameter pequipo2 = new SqlParameter("@equipo2", equipo2);
                pequipo2.SqlDbType = System.Data.SqlDbType.VarChar;
                pequipo2.Size = 50;

                SqlCommand cmd = new SqlCommand("MODIFICAR_MARCADORES_REALES", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(pfecha);
                cmd.Parameters.Add(phora);
                cmd.Parameters.Add(pmarcador1);
                cmd.Parameters.Add(pmarcador2);
                cmd.Parameters.Add(pequipo1);
                cmd.Parameters.Add(pequipo2);

                cmd.ExecuteScalar();
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
        }

        public static void insertar_pronostico(DateTime fecha, DateTime hora, string usuario, int marcador1, int marcador2, string equipo1, string equipo2)
        {
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);

                SqlParameter pfecha = new SqlParameter("@fecha", fecha);
                pfecha.SqlDbType = System.Data.SqlDbType.DateTime;

                SqlParameter phora = new SqlParameter("@hora", hora);
                phora.SqlDbType = System.Data.SqlDbType.DateTime;

                SqlParameter pusuario = new SqlParameter("@usuario", usuario);
                pusuario.SqlDbType = System.Data.SqlDbType.VarChar;
                pusuario.Size = 50;

                SqlParameter pmarcador1 = new SqlParameter("@marcador1", marcador1);
                pmarcador1.SqlDbType = System.Data.SqlDbType.Int;

                SqlParameter pmarcador2 = new SqlParameter("@marcador2", marcador2);
                pmarcador2.SqlDbType = System.Data.SqlDbType.Int;

                SqlParameter pequipo1 = new SqlParameter("@equipo1", equipo1);
                pequipo1.SqlDbType = System.Data.SqlDbType.VarChar;
                pequipo1.Size = 50;

                SqlParameter pequipo2 = new SqlParameter("@equipo2", equipo2);
                pequipo2.SqlDbType = System.Data.SqlDbType.VarChar;
                pequipo2.Size = 50;

                SqlCommand cmd = new SqlCommand("INSERTAR_PRONOSTICO", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(pfecha);
                cmd.Parameters.Add(phora);
                cmd.Parameters.Add(pusuario);
                cmd.Parameters.Add(pmarcador1);
                cmd.Parameters.Add(pmarcador2);
                cmd.Parameters.Add(pequipo1);
                cmd.Parameters.Add(pequipo2);

                cmd.ExecuteScalar();
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
        }

        public static DataTable vista_partidos_sjugar(string grupo)
        {
            DataTable dt = new DataTable();
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlParameter pgrupo = new SqlParameter("@grupo", grupo);
                pgrupo.SqlDbType = SqlDbType.VarChar;
                pgrupo.Size = 50;

                string script = "SELECT e1.nombre as Local, 'vs' as vs, e2.nombre as Visita, " +
                        "CONVERT(varchar, p.fecha, 103) as Fecha, CONVERT(varchar, p.hora, 108) as Hora " +
                        "FROM PARTIDO p "+
                        "INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo "+
                        "INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo "+
                        "INNER JOIN ASIGNACION_GRUPO ag ON e1.codequipo = ag.EQUIPO_codequipo "+
                        "INNER JOIN GRUPO g ON ag.GRUPO_codgrupo = g.codgrupo "+
                        "WHERE (marcador1 IS NULL and marcador2 IS NULL) and "+
                        "g.nombre = @grupo "+
                        "ORDER BY p.fecha";
                SqlCommand cmd = new SqlCommand(script, conn);
                cmd.Parameters.Add(pgrupo);
                dt.Load(cmd.ExecuteReader());
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return dt;
        }

        public static void actualizar_pronostico()
        {
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);                
                SqlCommand cmd = new SqlCommand("ACTUALIZR_PUNTOS_PRONOSTICO", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.ExecuteScalar();
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
        }

        public static DataTable vista_participantes_puntos()
        {
            DataTable dt = new DataTable();
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                string script = "SELECT u.nombre as Nombre, SUM(pr.puntos) as Puntos FROM PRONOSTICO pr " +
                    "INNER JOIN USUARIO u ON pr.USUARIO_nombre = u.nombre "+
                    "WHERE u.rol = 'participante' AND u.monto_pagado = 1 "+
                    "GROUP BY u.nombre "+
                    "ORDER BY Puntos DESC";
                SqlCommand cmd = new SqlCommand(script, conn);
                dt.Load(cmd.ExecuteReader());
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return dt;
        }

        public static DataSet vista_partido()
        {
            DataSet ds = new DataSet();
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("SELECT * FROM VISTA_PARTIDO_EQUIPOS", conn);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(ds);
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return ds;
        }

        public static void modificar_marcador_real(int marcador1, int marcador2, string equipo1, string equipo2)
        {
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);

                SqlParameter pmarcador1 = new SqlParameter("@mar1", marcador1);
                pmarcador1.SqlDbType = System.Data.SqlDbType.Int;

                SqlParameter pmarcador2 = new SqlParameter("@mar2", marcador2);
                pmarcador2.SqlDbType = System.Data.SqlDbType.Int;

                SqlParameter pequipo1 = new SqlParameter("@equipo1", equipo1);
                pequipo1.SqlDbType = System.Data.SqlDbType.VarChar;
                pequipo1.Size = 50;

                SqlParameter pequipo2 = new SqlParameter("@equipo2", equipo2);
                pequipo2.SqlDbType = System.Data.SqlDbType.VarChar;
                pequipo2.Size = 50;

                SqlCommand cmd = new SqlCommand("MODIFICAR_MARCADOR_REAL", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(pequipo1);
                cmd.Parameters.Add(pequipo2);
                cmd.Parameters.Add(pmarcador1);
                cmd.Parameters.Add(pmarcador2);

                cmd.ExecuteScalar();
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
        }
    }
}
