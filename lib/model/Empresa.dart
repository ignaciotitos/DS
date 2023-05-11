// Estructura de datos que almacena la información de la empresa
class Empresa {

  String _nombre = "mueblesIQUEA";
  String _direccion = "Centro Comercial Parque Nevada, Shopping Primera, Av. de las Palmeras, 75, Planta, 18100, Granada";
  String _telefono = "555-555-555";
  String _email = "info@mueblesIQUEA.com";
  String _descripcion = "Somos un grupo de jóvenes enamorados de la vida, de la "
      "belleza que nace de la imaginación y del talento de las personas. Nos "
      "encanta la naturaleza, los viajes y el arte en todas sus vertientes. "
      "Nuestro objetivo es crear piezas únicas que cambien tu forma de ver el "
      "mundo, que ayuden a expresarte y den personalidad a tu hogar. No se "
      "trata de un negocio, sino de un estilo de vida. Queremos que te "
      "diviertas, te emociones y te sorprendas día a día con nuestras alocadas"
      " ideas.";

  // Ruta al logo de la empresa
  String? _logo;

  String get nombre => _nombre;

  String get direccion => _direccion;

  String get telefono => _telefono;

  String get email => _email;

  String get descripcion => _descripcion;

  String? get logo => _logo;
}
