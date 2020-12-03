# BoltViewer

Una aplicación para asegurar el trabajo de mineros en faena, interpretando a travez de Bluetooth Low Energy  
la inestabilidad de la roca a partir de la medición de deformación mecanica de un perno inteligente (Rock Bolt Alert)  
con el que se va a trabajar en conjunto para dicha medición y recolección de datos. Esta aplicación, como se mencionó,  
recolecta los datos del perno (medición y nivel de batería, con fecha y hora), los muestra en una lista en pantalla con   
varios atributos y los sube a una base de datos del tipo Firebase al momento de tener conexión a internet. Luego de  
recolectar dichos datos, evalúa si la medición está dentro de un rango de *seguro*, de *precaución*, o de *peligro*.  
Si esta se encuentra en el rango de peligro, envía una alerta por pantalla, activando una alarma con vibración que  
debe ser apagada manualmente. La aplicación también tiene la funcionalidad de descargar todos los pernos (con la  
última medición subida) de la base de datos mencionada antes de hacer cualquier medición, los que se muestran en una  
lista bajo la lista de pernos encontrados por Bluetooth.

## Lista de Archivos

### main.dart

Se inicializa la aplicación y las rutas de MaterialApp, donde se establece una ruta para la pantalla de alarma  
y la pantalla principal de la lista de pernos.

### mainScreen.dart

Se contruye la pantalla principal en una columna con la lista de los pernos encontrados por Bluetooth con BluetoothStreamBuilder() y los pernos de la base de datos con FirebaseBolts()

### bluetoothScanner.dart

Este archivo es el encargado de controlar la conexión entre el perno y nuestra aplicación. Este está automatizado para buscar dispositivos Bluetooth cada 20 segundos.  
La funcion periodicBluetoothScanner() envía el Stream<List<Bolt>> con el que se actualiza el   
BluetoothStreambuilder() del MainScreen().

### bolt.dart

Permite ajustar los valores a los cuales se activan las alarmas y notificaciones, que alertan a los mineros en caso de posible derrumbe. Además, posee una clase, la cual   permite entregarle distintos atributos al perno, como lo son la batería, medición y fecha, con el fin de poder almacenar estos en la base de datos de Firebase.

### firebaseBoltStream.dart

Se declara un StreamController boltsFirebaseCtrl que emitirá el Stream<List<Bolt>> que actualiza al widget FirebaseStramBuilder para que contruya la lista de pernos de Firebase en pantalla. La funcion addBoltsFromFirebase()  
agrega una lista de pernos List<Bolt> a boltsFirebaseCtrl escuchando los cambios en firebase.

### uploadBolt.dart

Este código es el encargado de juntar todos los atributos entregados al resto del código y subirlos de manera ordenada a Firebase. se declara la funcion uploadBolt() que recive un perno como parametro y lo sube a firebase.

### alarmScreen.dart

Corresponde a la pantalla que muestra la alerta con la alarma (con vibración) una vez que se detecta un perno por Bluetooth con una medición lo suficientemente alta.  
Posee un texto descriptivo y un botón para apagar la alarma y remover la pantalla.

### errorScreen.dart

Pantalla que aparece al momento de haber un error con los datos recibidos en alguno de los streams. Diseñada para debugging llevado a cabo por los desarrolladores.

### loadingScreen.dart

Pantalla de carga que aparece al principio del inicio de la aplicación, mientras se cargan los datos de firebase.

### noBluetoothScreen.dart

Pantalla que debiese mostrar cuando se tiene el Bluetooth apagado, dando la posibilidad de encenderlo. Actualmente no se encuentra implementada.

### boltCard.dart

Widget que consiste en la tarjeta de información por cada perno, mostrado en pantalla como parte de una lista de más boltCards.

### blueBuilder.dart

Widget que recibe el Stream<List<Bolt>> por Bluetooth a través de la función periodicBluetoothScanner, posteriormente mostrándolos en pantalla como BoltCards.

### fireBuilder.dart

Widget que recibe el Stream<List<Bolt>>  de pernos alojados en la base de datos de Firebase entregado por boltsFirebaseCtrl.stream, posteriormente mostrándolos en pantalla como BoltCards.