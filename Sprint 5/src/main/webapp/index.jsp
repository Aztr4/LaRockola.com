

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
        <script src = "http://ajax.googleapis.com/ajax/libs/angularjs/1.2.15/angular.min.js"></script>
        <style>
            #liveAlertPlaceholder{
                width: 90%;
                margin: 20px auto;
            }
        </style>
    </head>
    <body>
        <div ng-app="Rockola" ng-controller="controladorCanciones">
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container-fluid">
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="#" ng-click="mostrarFormulario()">Inicio</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" ng-click="mostrarFormulario()">Guardar canción</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#" ng-click="listarCanciones()">Listar canciones</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <div id="liveAlertPlaceholder"></div>
            <div class="container-fluid" ng-show="!mostrarListaCanciones">
                <div class="row d-flex justify-content-center">
                    <div class="col-6" style="text-align: center" ng-show="!actualizar"><h1>Introducir nueva Canción</h1></div>
                    <div class="col-6" style="text-align: center" ng-show="actualizar"><h1>Actualizar cancion</h1></div>
                </div>
                <div class="row d-flex justify-content-center">
                    <div class="col-6">
                        <div class="mb-3">
                            <label for="exampleFormControlInput1" class="form-label">Nombre de la Canción*</label>
                            <input type="text" class="form-control" placeholder="Escriba el nombre de la canción" ng-model="nombreCancion">
                        </div>
                        <div class="mb-3">
                            <label for="exampleFormControlInput1" class="form-label">Artista(s) de la canción*</label>
                            <input type="text" class="form-control" placeholder="Escriba los artistas" ng-model="artista">
                        </div>
                        <label class="form-label">Genero</label>
                        <select class="form-select" aria-label="Default select example" ng-model="genero">
                            <option selected>Elija una opción</option>
                            <option>Salsa</option>
                            <option>Vallenato</option>
                            <option>Ranchera</option>
                            <option>Pop</option>
                            <option>Baladas</option>
                        </select><br/>

                        <div class="mb-3">
                            <label for="exampleFormControlInput1" class="form-label">Año</label>
                            <input type="text" class="form-control" placeholder="Escriba el año de publicación" ng-model="ano">
                        </div>

                        <button type="button" class="btn btn-warning" ng-click="guardarCancion()" ng-show="!actualizar">Guardar</button>
                        <button type="button" class="btn btn-warning" ng-click="actualizarCancion()" ng-show="actualizar">Actualizar</button>

                    </div>
                </div>
            </div>
            <div class="container-fluid" ng-show="mostrarListaCanciones">
                <div class="row d-flex justify-content-center">
                    <div class="col-6" style="text-align: center"><h1>Lista de canciones</h1></div>
                </div>
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Nombre de la Cancion</th>
                            <th scope="col">Artistas de la Canción</th>
                            <th scope="col">Genero</th>
                            <th scope="col">Año</th>
                            <th scope="col">Actualizar</th>
                            <th scope="col">Borrar</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr ng-repeat="cancion in canciones">
                            <th scope="row">{{cancion.nombreCancion}}</th>
                            <td>{{cancion.artista}}</td>
                            <td>{{cancion.genero}}</td>
                            <td>{{cancion.ano}}</td>
                            <td style="cursor: pointer" ng-click="mostrarFormActualizar(cancion)">actualizar</td>
                            <td style="cursor: pointer" ng-click="abrirModal(cancion.idCancion)">borrar</td>
                        </tr>
                    </tbody>
                </table>

                <!-- Modal -->
                <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Borrar canción</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                Está seguro que desea eliminar la canción?
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal" ng-click="eliminarCancion()">Eliminar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script src="ctrlCanciones.js"></script>
</html>
