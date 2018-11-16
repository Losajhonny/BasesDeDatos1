using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datos
{
    public class Usuario
    {
        public static bool monto_pagado = false;

        public static bool insertar_participante(string nombre, string apellido,
            int edad, bool monto_pagado, bool isAdmin, string pais)
        {
            bool ban = false;
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                SqlParameter pnombre = new SqlParameter("@nombre", nombre);
                pnombre.SqlDbType = System.Data.SqlDbType.VarChar;
                pnombre.Size = 50;

                SqlParameter papellido = new SqlParameter("@apellido", System.Data.SqlDbType.VarChar);
                papellido.Size = 50;
                if (apellido != null) { papellido.Value = apellido; }
                else { papellido.Value = DBNull.Value; }

                SqlParameter pedad = new SqlParameter("@edad", System.Data.SqlDbType.Int);
                if (edad == -1) { pedad.Value = 0; }
                else { pedad.Value = edad; }

                SqlParameter pmonto_pagado = new SqlParameter("@monto_pagado", System.Data.SqlDbType.Bit);
                pmonto_pagado.Value = monto_pagado;

                SqlParameter prol = new SqlParameter("@rol", System.Data.SqlDbType.VarChar);
                prol.Size = 50;
                if (!isAdmin) { prol.Value = "participante"; }
                else { prol.Value = "administrador"; }

                SqlParameter ppais = new SqlParameter("@pais", pais);
                ppais.SqlDbType = System.Data.SqlDbType.VarChar;
                ppais.Size = 50;

                SqlCommand cmd = new SqlCommand("INSERTAR_USUARIO", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(pnombre);
                cmd.Parameters.Add(papellido);
                cmd.Parameters.Add(pedad);
                cmd.Parameters.Add(pmonto_pagado);
                cmd.Parameters.Add(prol);
                cmd.Parameters.Add(ppais);

                cmd.ExecuteScalar();
                ban = true;
            }
            catch (Exception ex) {  }
            finally
            {
                Conexion.Conexion.closeConnect(conn);
            }
            return ban;
        }

        public static bool loguear(string nombre, string rol)
        {
            bool usuario = false;
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);

                SqlParameter pnombre = new SqlParameter("@nombre", nombre);
                pnombre.SqlDbType = System.Data.SqlDbType.VarChar;
                pnombre.Size = 50;

                SqlParameter prol = new SqlParameter("@rol", rol.ToLower());
                prol.SqlDbType = System.Data.SqlDbType.VarChar;
                prol.Size = 50;

                SqlCommand cmd = new SqlCommand("SELECT dbo.LOGUEAR(@nombre, @rol)", conn);
                cmd.Parameters.Add(pnombre);
                cmd.Parameters.Add(prol);

                object value = cmd.ExecuteScalar();
                usuario = Convert.ToBoolean(value);
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return usuario;
        }

        public static DataTable ultimo_reporte()
        {
            DataTable dt = new DataTable();
            SqlConnection conn = Conexion.Conexion.connect();
            try
            {
                Conexion.Conexion.openConnect(conn);
                string script = "SELECT e.nombre as Equipo, (SUM(p.puntos)+( "+
                    "SELECT SUM(p1.puntos) FROM PRONOSTICO p1 "+
                    "INNER JOIN EQUIPO e1 ON p1.EQUIPO_codequipo2 = e1.codequipo "+
                    "WHERE e.nombre = e1.nombre "+
                    "GROUP BY e1.nombre "+
                    ")) as Puntos FROM PRONOSTICO p "+
                    "INNER JOIN EQUIPO e ON p.EQUIPO_codequipo1 = e.codequipo "+
                    "GROUP BY e.nombre "+
                    "ORDER BY Puntos DESC";
                SqlCommand cmd = new SqlCommand(script, conn);
                dt.Load(cmd.ExecuteReader());
            }
            catch (Exception ex) { }
            finally { Conexion.Conexion.closeConnect(conn); }
            return dt;
        }
    }
}
