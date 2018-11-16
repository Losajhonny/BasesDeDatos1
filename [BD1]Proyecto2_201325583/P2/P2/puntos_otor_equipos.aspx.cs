using Datos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace P2
{
    public partial class puntos_otor_equipos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                grid_resultados.DataSource = Usuario.ultimo_reporte();
                grid_resultados.DataBind();
            }
        }
    }
}