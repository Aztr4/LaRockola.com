<%-- 
    Document   : peticionesCancion
    Created on : 26/09/2021, 08:28:44 PM
    Author     : User
--%>

<%@page import="java.util.List"%>
<%@page import="Logica.Canciones"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.google.gson.Gson"%>





<% 
String respuesta = "{";
String proceso = request.getParameter("proceso"); //request HTTP 
//a los request se les puede pasar parámetros
//se va a validar el tipo de proceso
Canciones c = new Canciones(); //se piden los parámetros del contacto que se quiere guardar
switch(proceso){
    case "guardarCancion":
        System.out.println("Guardar Cancion");
        c.setNombreCancion(request.getParameter("nombreCancion"));
        c.setArtista(request.getParameter("artista"));
        c.setGenero(request.getParameter("genero"));
        c.setAno(request.getParameter("ano"));

        if(c.guardarCancion()){
            //si guarda bien el contacto, se concatena otros datos para el json
            respuesta += "\"" + proceso + "\": true";  // el \ se usa para concatenar en json indicando que se hizo el proceso (true)
        } else{
            respuesta += "\"" + proceso + "\": false";  // el \ se usa para concatenar en json indicando que NO se hizo el proceso (false)
        }

        break;
        
case "actualizarCancion":
        
        System.out.println("Actualizar Cancion");
        c.setIdCancion(Integer.parseInt(request.getParameter("idCancion"))); //a este hay que convertirlo de entero a string
        c.setNombreCancion(request.getParameter("nombreCancion"));
        c.setArtista(request.getParameter("artista"));
        c.setGenero(request.getParameter("genero"));
        c.setAno(request.getParameter("ano"));
        if(c.actualizarCancion()){
            //si guarda bien el contacto, se concatena otros datos para el json
            respuesta += "\"" + proceso + "\": true";  // el \ se usa para concatenar en json indicando que se hizo el proceso (true)
        } else{
            respuesta += "\"" + proceso + "\": false";  // el \ se usa para concatenar en json indicando que NO se hizo el proceso (false)
        }


        
        break;
        
case "eliminarCancion":
        System.out.println("Eliminar cancion");
        int idCancion = Integer.parseInt(request.getParameter("idCancion"));
        if(c.borrarCancion(idCancion)){
         respuesta += "\"" + proceso + "\": true";  // el \ se usa para concatenar en json indicando que se hizo el proceso (true)
        } else{
            respuesta += "\"" + proceso + "\": false";  // el \ se usa para concatenar en json indicando que NO se hizo el proceso (false)
        }
        
        break;
        
case "listarCanciones":
        System.out.println("Listar Canciones");
        List<Canciones> listaCanciones = c.listarCanciones();
        if(listaCanciones.isEmpty()){
            respuesta += "\"" + proceso + "\": true,\"Canciones\":[]"; //genera una lista vacía en el json
        } else{
            respuesta += "\"" + proceso + "\": true,\"Canciones\":" + new Gson().toJson(listaCanciones); //guarda la lista en el json
        }
        
        break;
    //case "listarUnContacto":
    //    break;
        
    default:
        respuesta += "\"ok\": false,";
        respuesta += "\"error\": \"INVALID\",";
        respuesta += "\"errorMsg\": \"Lo sentimos, los datos que ha enviado,"
                + " son inválidos. Corrijalos y vuelva a intentar por favor.\"";

        
}

            // cierra la respuesta
respuesta += "}";
response.setContentType("application/json;charset=iso-8859-1");
out.print(respuesta);
%>
