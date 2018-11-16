using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos
{
    public class Grupo
    {
        public static bool insertar_grupo(string nombre)
        {
            bool correcto = false;
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlParameter pnombre = new SqlParameter("@nombre", nombre);
                pnombre.Size = 50;
                pnombre.SqlDbType = System.Data.SqlDbType.VarChar;

                SqlCommand cmd = new SqlCommand("INSERTAR_GRUPO", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.Parameters.Add(pnombre);

                cmd.ExecuteScalar();
                correcto = true;
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return correcto;
        }

        public static DataSet vista_grupo()
        {
            DataSet ds = new DataSet();
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("SELECT * FROM VISTA_GRUPO", conn);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(ds);
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return ds;
        }

        public static bool asignar_grupo(string equipo, string grupo)
        {
            bool correcto = false;
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlParameter pequipo = new SqlParameter("@equipo", equipo);
                pequipo.Size = 50;
                pequipo.SqlDbType = SqlDbType.VarChar;

                SqlParameter pgrupo = new SqlParameter("@grupo", grupo);
                pgrupo.Size = 50;
                pgrupo.SqlDbType = SqlDbType.VarChar;

                SqlCommand cmd = new SqlCommand("ASIGNAR_GRUPO", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(pequipo);
                cmd.Parameters.Add(pgrupo);
                cmd.ExecuteScalar();
                correcto = true;
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return correcto;
        }

        public static DataTable vista_equipo_grupo(string grupo)
        {
            DataTable dt = new DataTable();
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlParameter pgrupo = new SqlParameter("@grupo", grupo);
                pgrupo.SqlDbType = SqlDbType.VarChar;
                pgrupo.Size = 50;

                SqlCommand cmd = new SqlCommand("SELECT ROW_NUMBER() OVER(ORDER BY nombre) as No, nombre as Equipo FROM dbo.EQUIPOS_POR_GRUPO(@grupo)", conn);
                cmd.Parameters.Add(pgrupo);
                dt.Load(cmd.ExecuteReader());
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return dt;
        }

        public static DataTable vista_equipo_por_grupo(string grupo)
        {
            DataTable dt = new DataTable();
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlParameter pgrupo = new SqlParameter("@grupo", grupo);
                pgrupo.SqlDbType = SqlDbType.VarChar;
                pgrupo.Size = 50;

                string script = "SELECT ROW_NUMBER() OVER(ORDER BY ag.puntos DESC) as No, e.nombre as Equipo, " +
                    "( " +
                        "SELECT COUNT(*) " +
                        "FROM PARTIDO p " +
                        "INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo " +
                        "INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo " +
                        "WHERE (e1.codequipo = e.codequipo OR e2.codequipo = e.codequipo) " +
                        "AND (marcador1 IS NOT NULL and marcador2 IS NOT NULL) " +
                    ") as PJ, " +
                    "( " +
                        "SELECT COUNT(*) " +
                        "FROM PARTIDO P " +
                        "INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo " +
                        "INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo " +
                        "WHERE (e1.codequipo = e.codequipo AND p.marcador1 > p.marcador2) " +
                        "OR (e2.codequipo = e.codequipo AND p.marcador2 > p.marcador1) " +
                        "AND (marcador1 IS NOT NULL and marcador2 IS NOT NULL) " +
                    ") as G, " +
                    "( " +
                        "SELECT COUNT(*) " +
                        "FROM PARTIDO P " +
                        "INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo " +
                        "INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo " +
                        "WHERE (e1.codequipo = e.codequipo OR e2.codequipo = e.codequipo) " +
                        "AND p.marcador2 = p.marcador1 " +
                        "AND (marcador1 IS NOT NULL and marcador2 IS NOT NULL) " +
                    ") as E, " +
                    "( " +
                        "SELECT COUNT(*) " +
                        "FROM PARTIDO P " +
                        "INNER JOIN EQUIPO e1 ON p.EQUIPO_codequipo1 = e1.codequipo " +
                        "INNER JOIN EQUIPO e2 ON p.EQUIPO_codequipo2 = e2.codequipo " +
                        "WHERE (e1.codequipo = e.codequipo AND p.marcador1 < p.marcador2) " +
                        "OR (e2.codequipo = e.codequipo AND p.marcador2 < p.marcador1) " +
                        "AND (marcador1 IS NOT NULL and marcador2 IS NOT NULL) " +
                    ") as P, " +
                    "ag.puntos as Pts " +
                    "FROM ASIGNACION_GRUPO ag " +
                    "INNER JOIN EQUIPO e ON ag.EQUIPO_codequipo = e.codequipo " +
                    "INNER JOIN GRUPO g ON ag.GRUPO_codgrupo = g.codgrupo " +
                    "WHERE g.nombre = @grupo " +
                    "ORDER BY ag.puntos DESC";
                SqlCommand cmd = new SqlCommand(script, conn);
                cmd.Parameters.Add(pgrupo);
                dt.Load(cmd.ExecuteReader());
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return dt;
        }

        public static bool eliminar_asignacion_grupo(string equipo, string grupo)
        {
            bool correcto = false;
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlParameter pequipo = new SqlParameter("@equipo", equipo);
                pequipo.Size = 50;
                pequipo.SqlDbType = SqlDbType.VarChar;

                SqlParameter pgrupo = new SqlParameter("@grupo", grupo);
                pgrupo.Size = 50;
                pgrupo.SqlDbType = SqlDbType.VarChar;

                SqlCommand cmd = new SqlCommand("ELIMINAR_ASIGNACION_GRUPO", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(pequipo);
                cmd.Parameters.Add(pgrupo);
                cmd.ExecuteScalar();
                correcto = true;
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return correcto;
        }

        public static void actualizar_puntos_grupo()
        {
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlCommand cmd = new SqlCommand("ACTUALIZAR_PUNTOS_PARTIDO", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.ExecuteScalar();
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
        }
    }
}
