using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Office.Interop.Excel;
using SpreadsheetLight;
using Datos;

namespace P2
{
    public partial class carga : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btn_upmr.Enabled = false;
            }
        }

        public string moverArchivo(FileUpload upload)
        {
            string fn = null;
            if (upload.HasFile)
            {
                fn = System.IO.Path.GetFileName(upload.PostedFile.FileName);
                upload.SaveAs("C:\\ArchivosAdjunto\\" + fn);
            }
            return "C:\\ArchivosAdjunto\\"+fn;
        }

        public void cargar_upload_jecp(string path)
        {
            SLDocument sl = new SLDocument(path);   //Leer el archivo excel
            for (int i = 0; i < sl.GetWorksheetNames().Count; i++)  //Recorrer las hojas de trabajo
            {
                int tipo_hoja = 3;
                if ((sl.GetWorksheetNames()[i].ToLower().Equals("jugadores"))) { tipo_hoja = 0; }
                else if ((sl.GetWorksheetNames()[i].ToLower().Equals("equipos"))) { tipo_hoja = 1; }
                else if ((sl.GetWorksheetNames()[i].ToLower().Equals("catalogojuegos"))) { tipo_hoja = 2; }
                sl.SelectWorksheet(sl.GetWorksheetNames()[i]);  //Seleccionando la primera hoja
                //iniciar en la fila 2
                int iRow = 2;


                if (tipo_hoja == 0)
                {//jugadores
                    while (!string.IsNullOrEmpty(sl.GetCellValueAsString(iRow, 1)))
                    {
                        string equipo = sl.GetCellValueAsString(iRow, 1);
                        int nocamisola = sl.GetCellValueAsInt32(iRow, 2);
                        string posicion = sl.GetCellValueAsString(iRow, 3);
                        string nombre = sl.GetCellValueAsString(iRow, 4);
                        DateTime fecha = sl.GetCellValueAsDateTime(iRow, 5);//no tomar en cuenta debido al poco tiempo que hay de entrega
                        int altura = sl.GetCellValueAsInt32(iRow, 6);
                        int peso = sl.GetCellValueAsInt32(iRow, 7);
                        int goles = sl.GetCellValueAsInt32(iRow, 8);
                        //Insertando jugador
                        Jugador.insertar_jugador_carga(nocamisola, posicion, nombre, fecha, altura, peso, goles, equipo);
                        iRow++;
                    }
                }
                else if(tipo_hoja == 1)
                {//equipos
                    while (!string.IsNullOrEmpty(sl.GetCellValueAsString(iRow, 1)))
                    {
                        string equipo = sl.GetCellValueAsString(iRow, 1);
                        string confede = sl.GetCellValueAsString(iRow, 2);
                        string grupo = sl.GetCellValueAsString(iRow, 3);
                        //Insertando equipo, confede, grupo
                        Equipo.cargar_equipos(equipo, confede, grupo);
                        iRow++;
                    }
                }
                else if (tipo_hoja == 2)
                {//catalogos
                    while (!string.IsNullOrEmpty(sl.GetCellValueAsString(iRow, 1)))
                    {
                        DateTime fecha = sl.GetCellValueAsDateTime(iRow, 1);
                        DateTime hora = sl.GetCellValueAsDateTime(iRow, 2);
                        string sede = sl.GetCellValueAsString(iRow, 3);
                        string[] arbitroc = { sl.GetCellValueAsString(iRow, 4), "central" };
                        string[] arbitro1 = { sl.GetCellValueAsString(iRow, 5), "asistente" };
                        string[] arbitro2 = { sl.GetCellValueAsString(iRow, 6), "asistente" };
                        string equipo1 = sl.GetCellValueAsString(iRow, 7);
                        string equipo2 = sl.GetCellValueAsString(iRow, 8);
                        Partido.cargar_partidos(fecha, hora, sede, arbitroc, arbitro1, arbitro2, equipo1, equipo2);
                        iRow++;
                    }
                }
            }
        }

        public void cargar_upload_upmr(string path)
        {
            SLDocument sl = new SLDocument(path);   //Leer el archivo excel
            for (int i = 0; i < sl.GetWorksheetNames().Count; i++)  //Recorrer las hojas de trabajo
            {
                int tipo_hoja = 3;
                if ((sl.GetWorksheetNames()[i].ToLower().Equals("usuarios"))) { tipo_hoja = 0; }
                else if ((sl.GetWorksheetNames()[i].ToLower().Equals("pronostico"))) { tipo_hoja = 1; }
                else if ((sl.GetWorksheetNames()[i].ToLower().Equals("marcadorreal"))) { tipo_hoja = 2; }
                sl.SelectWorksheet(sl.GetWorksheetNames()[i]);  //Seleccionando la primera hoja
                //iniciar en la fila 2
                int iRow = 2;

                if (tipo_hoja == 0)
                {//usuarios
                    while (!string.IsNullOrEmpty(sl.GetCellValueAsString(iRow, 1)))
                    {
                        string nombre = sl.GetCellValueAsString(iRow, 1);
                        int edad = sl.GetCellValueAsInt32(iRow, 2);
                        string pais = sl.GetCellValueAsString(iRow, 3);
                        int monto = sl.GetCellValueAsInt32(iRow, 4);
                        bool pagado = (monto == 100) ? true : false;
                        Usuario.insertar_participante(nombre, null, edad, pagado, false, pais);
                        iRow++;
                    }
                }
                else if (tipo_hoja == 1)
                {//pronosticos
                    while (!string.IsNullOrEmpty(sl.GetCellValueAsString(iRow, 1)))
                    {
                        DateTime fecha = sl.GetCellValueAsDateTime(iRow, 1);
                        DateTime hora = sl.GetCellValueAsDateTime(iRow, 2);
                        string usuario = sl.GetCellValueAsString(iRow, 3);
                        string equipo1 = sl.GetCellValueAsString(iRow, 4);
                        int marcador1 = sl.GetCellValueAsInt32(iRow, 5);
                        int marcador2 = sl.GetCellValueAsInt32(iRow, 6);
                        string equipo2 = sl.GetCellValueAsString(iRow, 7);
                        Partido.insertar_pronostico(fecha, hora, usuario, marcador1, marcador2, equipo1, equipo2);
                        iRow++;
                    }
                }
                else if (tipo_hoja == 2)
                {//marcadores reales
                    while (!string.IsNullOrEmpty(sl.GetCellValueAsString(iRow, 1)))
                    {
                        DateTime fecha = sl.GetCellValueAsDateTime(iRow, 1);
                        DateTime hora = sl.GetCellValueAsDateTime(iRow, 2);
                        string equipo1 = sl.GetCellValueAsString(iRow, 3);
                        int marcador1 = sl.GetCellValueAsInt32(iRow, 4);
                        int marcador2 = sl.GetCellValueAsInt32(iRow, 5);
                        string equipo2 = sl.GetCellValueAsString(iRow, 6);
                        Partido.modificar_marcador(fecha, hora, marcador1, marcador2, equipo1, equipo2);
                        iRow++;
                    }
                }
            }
        }

        public bool validacionExcel(FileUpload upload)
        {
            return (upload.PostedFile.FileName.EndsWith(".xls") || upload.PostedFile.FileName.EndsWith(".xlsx"));
        }

        protected void btn_jecp_Click(object sender, EventArgs e)
        {
            string mensaje;
            if (upload_jecp.HasFile)
            {
                if (validacionExcel(upload_jecp))
                {
                    string path = moverArchivo(upload_jecp);
                    if (path != null)
                    {
                        btn_upmr.Enabled = true;
                        cargar_upload_jecp(path);
                    }
                }
                else
                {
                    mensaje = "mensaje('','info','Extensiones validos .xls y .xlsx','" + login.TOP_END_BIG.ToString() + "')";
                    ClientScript.RegisterStartupScript(this.GetType(), "id", mensaje, true);
                }
            }
            else
            {
                mensaje = "mensaje('','info','No se ha adjuntado ningun archivo','" + login.TOP_END_BIG.ToString() + "')";
                ClientScript.RegisterStartupScript(this.GetType(), "id", mensaje, true);
            }
        }

        protected void btn_upmr_Click(object sender, EventArgs e)
        {
            string mensaje;
            if (upload_upmr.HasFile)
            {
                if (validacionExcel(upload_upmr))
                {
                    string path = moverArchivo(upload_upmr);
                    if (path != null)
                    {
                        cargar_upload_upmr(path);
                    }
                }
                else
                {
                    mensaje = "mensaje('','info','Extensiones validos .xls y .xlsx','" + login.TOP_END_BIG.ToString() + "')";
                    ClientScript.RegisterStartupScript(this.GetType(), "id", mensaje, true);
                }
            }
            else
            {
                mensaje = "mensaje('','info','No se ha adjuntado ningun archivo','" + login.TOP_END_BIG.ToString() + "')";
                ClientScript.RegisterStartupScript(this.GetType(), "id", mensaje, true);
            }
        }
    }
}