# ConectaPro + Supabase

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

## 4. Probar el flujo

1. Abre la pagina.
2. Ve a `Crear solicitud`.
3. Completa el formulario.
4. Envia la solicitud.
5. Verifica en `Table Editor > service_requests` que el registro exista.
6. Vuelve a `Solicitudes` y confirma que aparezca en la grilla.

## 5. Siguiente paso recomendado

Cuando este flujo quede validado, seguimos con:
- autenticacion de clientes y profesionales
- upload real de imagenes al bucket
- chat en tiempo real con `request_messages`
- presupuestos reales con `request_quotes`
