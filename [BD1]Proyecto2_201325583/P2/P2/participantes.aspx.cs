using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace P2
{
    public partial class participantes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //actualizar los puntos
                Partido.actualizar_pronostico();
                //actualizar tabla
                grid_participantes.DataSource = Partido.vista_participantes_puntos();
                grid_participantes.DataBind();
            }
        }
    }
}