# iMovies
## _Películas y series_

[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

Proyecto desarrollado usando MVVM como patrón de arquitectura de software, usando también como base los principios de SOLID e injección de dependencias.

Ejemplo de la app funcionando de manera online y offline
https://www.youtube.com/watch?v=kG-2cPFZFiE

## Descripción de Capas :

- Models: Modelos de la entidades del proyecto
- Views: Vistas de diseño
- ViewModel : Lógica de negocio
- Router: Encargado de navegar por los diferentes controladores
- Persistence: Lógica donde se maneja toda la parte de persistencia de datos
- Services : Manjeador de peticiones a las apis
- Manager: Controla las peticiones de datos, convirtiendolas en los modelos necesarios y decide si hacer la petición online u offline
- Resources : Ultities, Helpers, Extensions, Constants, etc
## Persistence :
- PersistenceDataManager : Contiene funciones encargadas de guardar de forma relacional los datos obtenidos desde la web y las imagenes descragadas, para consultas offline.
## Services
- TheMovieDBServiceProtocol : Protocólo para la realización de requests a la API the TheMovieDb 
- TheMovieDBService : Clase que implementa el protocólo para las petciones a la API
- APIService : Singleton encargada de realizar las petciones a la API y desearilzar los JSON y convertirlos en modelos.
- RealmService: Singleton encargado de guardar, leer, eliminar y actualizar los datos en una base de datos local (CRUD).
## Manager
- MoviesManagerProtocol: Protocólo que abstrae todas las peticiones que se realizan dentro de la aplicación y que devuleven los datos ya organizados como se requieren para ser mostrados al usuario.
- MoviesDBManager: Clase que implementa a MoviesManagerProtocol y que realiza las peticiones de manera online.
- MoviesLocalDBManager: Clase que implementa a MoviesManagerProtocol y que realiza las peticiones de manera offline.
- MoviesManagerHelper: Helper que decide cual clase realizará las peticiones, dependiendo si hay conexión a internet o no.
 ## Principio de responsabilidad unica: 
Es el primer principio de SOLID. Indica que cada clase debe ser encargada unicamente de una sola cosa, es decir debe tener una unica responsabilidad de ejecución, todas las variables, funciones o metodos deben estar alineados con esa responsabilidad, de esta manera tendremos un còdigo mejor organizado y escalable.

## Un buen código según yo:
A estas alturas de mi vida como desarrollador, puedo decir que un buen código debe, como principio, estar basado en una y solo una arquitectura de sofware, ya sea MVC, MVVM, Viper, etc. Comentar el codigo o las funciones que no sean tan obvias, el uso de injeccion de dependecias ya es un MUST y seguir, en la medida de lo posible, los principios de SOLID, de esta manera cualquier otro desarrollador podrá leer y realizar coambios en el código sin problema.
Debe contener pruebas unitarias de las principales fuciones del proyecto.
