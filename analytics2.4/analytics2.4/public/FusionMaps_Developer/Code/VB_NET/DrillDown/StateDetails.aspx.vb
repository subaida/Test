Imports InfoSoftGlobal

Partial Class DrillStateDetails
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' Define dataURL 
        Dim dataURL As String
        ' URLEncode dataURL
        dataURL = Server.UrlEncode("DataGen.aspx?op=GetStateDetails&Internal_Id=" & Request("Internal_Id"))

        ' Create the Map with data contained in dataURL 
        ' and embed the chart rendered as HTML into Literal - StateDetailsMap
        ' We use FusionMaps class of InfoSoftGlobal namespace (FusionMaps.dll in BIN folder)
        ' RenderMap() generates the necessary HTML needed to render the map
        Dim mapHTML As String = FusionMaps.RenderMap("../Maps/" + Request("map"), dataURL, "", "mapid", "600", "400", False, False)

        ' embed the chart rendered as HTML into Literal - StateDetailsMap
        StateDetailsMap.Text = mapHTML

    End Sub
End Class
