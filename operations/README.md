# Cloud Operations Sample

## Deploy application to App Engine

Create application for the first time using:

```bash
gcloud app deploy ./packages/dispatch.yaml ./packages/frontend/app.yaml ./packages/orders/app.yaml ./packages/payments/app.yaml
```

## How to test application

1. Deploy application to App Engine
1. Visit main page of the application (`/`) and place order
1. Copy order ID
1. Make request to payments endpoint with order ID

### Sample Payments request

```bash
curl -X POST -d '{ "data": { "order": { "id": "<ORDER_ID>" } } }' -H 'Content-type: application/json' <APP_ENGINE_URL>/payments/
```
