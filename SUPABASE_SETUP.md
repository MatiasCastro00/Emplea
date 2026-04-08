# Emplea + Supabase

## 1. Configuracion del cliente

La app toma la configuracion desde `app-config.js`.

Archivo actual:
- `url`: proyecto de Supabase
- `publishableKey`: clave publica para el frontend
- `storageBucket`: bucket sugerido para imagenes de solicitudes

Si despues queres cambiar de proyecto, copia `app-config.example.js` sobre `app-config.js` y completa los valores.

## 2. Crear el esquema base

1. Entra a tu proyecto de Supabase.
2. Abre `SQL Editor`.
3. Ejecuta el contenido de `supabase/schema.sql`.

Eso crea:
- `profiles`
- `service_requests`
- `request_quotes`
- `request_messages`

Y deja habilitado:
- lectura publica de solicitudes abiertas
- insercion publica de nuevas solicitudes

## 3. Bucket para fotos

La UI todavia no sube archivos reales, pero ya queda preparado el nombre del bucket.

En `Storage` crea un bucket llamado `request-images`.

Configuracion recomendada para el MVP:
- Public bucket: `true`

## 4. Configurar autenticacion

La UI ahora soporta:
- registro con email y contraseña
- login con email y contraseña
- login social con Google

### 4.1 URL Configuration

En `Authentication > URL Configuration` configura:
- `Site URL`: tu URL local o la URL publica de Netlify
- `Redirect URLs`: agrega al menos:
  - `http://127.0.0.1:5500`
  - `http://localhost:5500`
  - tu dominio de Netlify

Si pruebas con otra URL local o preview, agregala tambien.

### 4.2 Email

En `Authentication > Providers > Email`:
- habilita `Email`

### 4.3 Google

En `Authentication > Providers > Google`:
- habilita `Google`
- crea las credenciales OAuth en Google Cloud
- copia en Google el callback que te muestra Supabase en esa misma pantalla
- pega en Supabase el `Client ID` y `Client Secret`

## 5. Probar el flujo

1. Abre la pagina.
2. Prueba `Ingresar` o `Registrarme`.
3. Valida email/password o login social.
4. Ve a `Crear solicitud`.
5. Completa el formulario.
6. Envia la solicitud.
7. Verifica en `Table Editor > service_requests` que el registro exista.
8. Vuelve a `Solicitudes` y confirma que aparezca en la grilla.

## 6. Siguiente paso recomendado

Cuando este flujo quede validado, seguimos con:
- autenticacion de clientes y profesionales
- upload real de imagenes al bucket
- chat en tiempo real con `request_messages`
- presupuestos reales con `request_quotes`
