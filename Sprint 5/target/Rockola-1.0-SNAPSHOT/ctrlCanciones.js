var app = angular.module('Rockola', []);

app.controller('controladorCanciones', function ($scope, $http) {
    var alertPlaceholder = document.getElementById('liveAlertPlaceholder');

    function alertBootstrap(message, type) {
        var wrapper = document.createElement('div')
        wrapper.innerHTML = '<div class="alert alert-' + type + ' alert-dismissible" role="alert">' + message + '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>'

        alertPlaceholder.append(wrapper)
    }

    $scope.guardarCancion = function () {
        let regexNumbers = /^[0-9]*$/;

        if ($scope.nombreCancion === undefined || $scope.genero === undefined) {
            alert('Estos campos son obligatorios');
        } else {
            console.log('Entra a guardarCancion');
            let canciones = {
                proceso: 'guardarCancion',
                nombreCancion: $scope.nombreCancion,
                artista: $scope.artista,
                genero: $scope.genero,
                ano: $scope.ano,
            };

            $http({
                method: 'POST',
                url: 'peticionesCancion.jsp',
                params: canciones
            }).then(function (respuesta) {
                console.log(respuesta);
                if (respuesta.data.guardarCancion) {
                    alert('Guardado Exitoso');
                    $scope.listarCanciones();
                } else {
                    alert('Error al guardar en la BD');
                }
            }).catch(function (error) {
                alert('Servicio no disponible, intente más tarde!');
                console.log(error);
            });
        }
    };

    $scope.listarCanciones = function () {
        $scope.mostrarListaCanciones = true;
        let params = {
            proceso: 'listarCanciones'
        };

        $http({
            method: 'GET',
            url: 'peticionesCancion.jsp',
            params: params
        }).then(function (respuesta) {
            $scope.canciones = respuesta.data.Canciones;
            console.log($scope.canciones);
        });
    };

    $scope.eliminarCancion = function () {
        let params = {
            proceso: 'eliminarCancion',
            idCancion: $scope.idParaEliminar
        };
        $http({
            method: 'GET',
            url: 'peticionesCancion.jsp',
            params: params
        }).then(function (respuesta) {
            if (respuesta.data.eliminarCancion) {
                alertBootstrap('Cancion eliminado exitosamente!', 'success');
                $scope.listarCancion();
            } else {
                alert('Error al eliminar contacto');
            }

        });
    };

    $scope.actualizarCancion = function () {
        let params = {
            proceso: 'actualizarCancion',
            idCancion: $scope.idCancion,
            nombreCancion: $scope.nombreCancion,
            artista: $scope.artista,
            genero: $scope.genero,
            ano: $scope.ano,
        };

        $http({
            method: 'GET',
            url: 'peticionesCancion.jsp',
            params: params
        }).then(function (respuesta) {
            if (respuesta.data.actualizarCancion) {
                alert('Actualización exitosa');
                $scope.listarCanciones();
            } else {
                alert('No se pudo actualizar');
            }
            console.log(respuesta);
        });
    };

    $scope.mostrarFormulario = function () {
        $scope.mostrarListaCanciones = false;
    };

    $scope.mostrarFormActualizar = function (cancion) {
        $scope.mostrarListaCanciones = false;
        $scope.actualizar = true;
        $scope.idCancion= cancion.idCancion;
        $scope.nombreCancion = cancion.nombreCancion;
        $scope.artista = cancion.artista;
        $scope.genero = cancion.genero;
        $scope.ano = cancion.ano;
    };

    $scope.abrirModal = function (nombreCancion) {
        $scope.idParaEliminar = nombreCancion;
        var myModal = new bootstrap.Modal(document.getElementById('exampleModal'), {
            keyboard: false
        });
        myModal.show();
    };
});


