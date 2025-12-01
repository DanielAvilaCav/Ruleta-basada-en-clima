# Casino Ruleta - Simulador Climático

Aplicación web desarrollada en **Ruby on Rails** que simula una mesa de casino dinámica. La característica principal es una **IA basada en reglas** que modifica el comportamiento de riesgo de los apostadores dependiendo del clima real de la ciudad (Santiago, Chile).

**URL de Producción:** [https://casino-ruleta-daniel.onrender.com]

##  Descripción del Proyecto

El sistema gestiona una mesa de ruleta automatizada donde múltiples jugadores realizan apuestas simultáneas. El sistema consume la API de **OpenWeatherMap** para obtener datos meteorológicos en tiempo real y condicionar la estrategia de juego.

### Inteligencia Artificial y Lógica de Negocio
El sistema implementa una lógica de comportamiento condicionada por variables externas:

*  **Clima Despejado (Soleado)**: Los jugadores se vuelven **agresivos**. Aumentan su porcentaje de apuesta y arriesgan más al color Verde (mayor pago, menor probabilidad).
* **Clima Lluvioso:** Los jugadores se vuelven **conservadores**. Apuestan porcentajes menores (70% de lo habitual) y prefieren colores seguros (Rojo/Negro).
* **Clima Nieve:** Comportamiento **muy conservador** (50% de la apuesta habitual).
* **Nublado:** Comportamiento estándar.

##  Funcionalidades Principales

1.  **Gestión de Jugadores (CRUD):**
    * Registro de jugadores con un balance inicial de **$10.000**.
    * Edición y eliminación de participantes.
2.  **Sistema de Apuestas:**
    * Apuesta automática entre el **8% y 15%** del saldo.
    * Regla **"All In"**: Si el saldo es ≤ $1.000, se apuesta todo.
3.  **Probabilidades Reales:**
    * Verde: 2% (Pago x15).
    * Rojo/Negro: 49% (Pago x2).
4.  **Automatización:**
    * El sistema ejecuta rondas automáticamente cada **3 minutos**.
    * Implementación híbrida: Cron jobs (backend) y Trigger por visita (controlador) para asegurar la ejecución en servicios gratuitos.
5.  **Interfaz en Tiempo Real (SPA):**
    * Uso de **Turbo/Hotwire** para actualizaciones de saldo y rondas sin recargar la página.
    * Temporizador visual regresivo.

##  Stack Tecnológico

* **Lenguaje:** Ruby 
* **Framework:** Rails 
* **Base de Datos:** PostgreSQL
* **APIs:** OpenWeatherMap API
* **Gemas Clave:** `httparty` (Conexión API), `whenever` (Cron jobs), `dotenv-rails`.

##  Instalación Local

Si deseas correr este proyecto en tu máquina local:

1.  **Clonar el repositorio:**
    ```bash
    git clone <https://github.com/DanielAvilaCav/Ruleta-basada-en-clima>
    cd casino_ruleta
    ```

2.  **Instalar dependencias:**
    ```bash
    bundle install
    ```

3.  **Configurar Base de Datos:**
    Asegúrate de tener PostgreSQL y modificar en database.yml el username y password.
    ```bash
    rails db:create
    rails db:migrate
    ```

4.  **Variables de Entorno:**
    Crea un archivo `.env` en la raíz y agrega tu API Key:
    ```env
    OPENWEATHERMAP_API_KEY=tu_clave_api_aqui
    ```

5.  **Iniciar Servidor:**
    ```bash
    rails s
    ```
    Visita `http://localhost:3000`.

##  Despliegue en Producción (Render)

El proyecto está configurado para desplegarse en [Render](https://render.com) siguiendo estos parámetros:

* **Build Command:** `bundle install; bundle exec rails assets:precompile; bundle exec rails db:migrate`
* **Start Command:** `bundle exec rails server`
* **Environment Variables:**
    * `RAILS_MASTER_KEY`: (Contenido de config/master.key)
    * `OPENWEATHERMAP_API_KEY`: (Tu API Key)
    * `DATABASE_URL`: (Internal URL de la base de datos PostgreSQL en Render)

---
**Autor:** Daniel Avila
*Proyecto desarrollado para evaluación práctica Nnodes.*