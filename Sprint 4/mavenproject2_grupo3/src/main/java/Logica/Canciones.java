/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica;

import Persistencia.ConexionBD;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author LINDIS
 */
public class Canciones {
    private int idCancion; 
    private String nombreCancion;
    private String artista;
    private String genero;
    private String ano;
 
    
    public Canciones(){
        
    }

    public int getIdCancion() {
        return idCancion;
    }

    public void setIdCancion(int idCancion) {
        this.idCancion = idCancion;
    }

    public String getNombreCancion() {
        return nombreCancion;
    }

    public void setNombreCancion(String nombreCancion) {
        this.nombreCancion = nombreCancion;
    }

    public String getArtista() {
        return artista;
    }

    public void setArtista(String artista) {
        this.artista = artista;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public String getAno() {
        return ano;
    }

    public void setAno(String ano) {
        this.ano = ano;
    }
    
    
    public boolean guardarCancion(){
       ConexionBD conexion = new ConexionBD();
       String sentencia = "INSERT INTO canciones(nombreCancion, artista, genero, ano)"
        + " VALUES ( '"+ this.nombreCancion + "','" + this.artista + "','" + this.genero + "','" + this.ano + "'); ";
   
       if(conexion.setAutoCommitBD(false)){
            if(conexion.insertarBD(sentencia)){
                conexion.commitBD();
                conexion.closeConnection();
                return true;
            } else{ //si no logro insertar en la BD
                conexion.rollbackBD();
                conexion.closeConnection();
                return false;
    }
       }else {
           conexion.closeConnection();
           return false;
       }
    }
    
    public boolean borrarCancion(int idCancion){
        ConexionBD conexion = new ConexionBD();
        String sentencia = "DELETE FROM Canciones WHERE idCancion = '" + idCancion + "'";
        if(conexion.setAutoCommitBD(false)){
            if(conexion.borrarBD(sentencia)){
                conexion.commitBD();
                conexion.closeConnection();
                return true;
            } else{
                conexion.rollbackBD();
                conexion.closeConnection();
                return false;
            }
        } else {
            conexion.closeConnection();
            return false;
        }
    }
    
    public boolean actualizarCancion(){
        ConexionBD conexion = new ConexionBD();
        String sentencia = "UPDATE `Canciones` SET nombreCancion='" + this.nombreCancion + "',artista='" + this.artista + "',genero='" + this.genero
                + "',ano='" + this.ano + "' WHERE idCancion='"+this.idCancion+"'";

        if(conexion.setAutoCommitBD(false)){
            if(conexion.actualizarBD(sentencia)){
                conexion.commitBD();
                conexion.closeConnection();
                return true;
            } else{
                conexion.rollbackBD();
                conexion.closeConnection();
                return false;
            }
           
        } else{
            conexion.closeConnection();
            return false;
        }
    }
    
    public List<Canciones> listarCanciones() throws SQLException{
        ConexionBD conexion = new ConexionBD();
        String sentencia = "SELECT * FROM Canciones ORDER BY idCancion ASC;";
        List<Canciones> listaCanciones = new ArrayList<>();
        ResultSet datos = conexion.consultarBD(sentencia);
        
        Canciones cancion;
        while (datos.next()) {
            cancion = new Canciones();
            cancion.setIdCancion(datos.getInt("idCancion"));
            cancion.setNombreCancion(datos.getString("nombreCancion"));
            cancion.setArtista(datos.getString("artista"));
            cancion.setGenero(datos.getString("genero"));
            cancion.setAno(datos.getString("Ano"));
            
            listaCanciones.add(cancion);
            
        }
        conexion.closeConnection();
        return listaCanciones;
    }
public Canciones obtenerCanciones (int idCancion) throws SQLException{
        ConexionBD conexion = new ConexionBD();
        String sentencia = "SELECT * FROM Canciones WHERE idCancion = '" + idCancion + "';";
        ResultSet datos = conexion.consultarBD(sentencia);
        if(datos.next()){
            Canciones cancion = new Canciones();
            cancion.setIdCancion(datos.getInt("idCancion"));
            cancion.setNombreCancion(datos.getString("nombreCancion"));
            cancion.setArtista(datos.getString("artista"));
            cancion.setGenero(datos.getString("genero"));
            cancion.setAno(datos.getString("Ano"));
            return cancion;
        } else{
            conexion.closeConnection();
            return null;
        }
    
    }
}

