# LiteLLM sample

This sample deploys an OpenAI-compatible LiteLLM proxy at
`http://litellm.k8s.orb.local`, backed by PostgreSQL. It exposes the
`gpt-5.6-terra` model alias and routes requests to OpenAI. Update
`litellm-config.yaml` and `litellm-all.yaml` to configure a different provider
or model.

The sample requires the repository's Traefik bootstrap. PostgreSQL persists
Admin UI models, virtual keys, and spend tracking data in a 5-GiB PVC.

## Install

Create the LiteLLM, PostgreSQL, and OpenAI secrets locally. They are not stored
in this repository:

```sh
export LITELLM_MASTER_KEY="sk-$(openssl rand -hex 32)"
export LITELLM_SALT_KEY="$(openssl rand -hex 32)"
export POSTGRES_PASSWORD="$(openssl rand -hex 24)"
export OPENAI_API_KEY="your-openai-api-key"
export DATABASE_URL="postgresql://litellm:${POSTGRES_PASSWORD}@postgres.litellm.svc.cluster.local:5432/litellm"
kubectl apply -f litellm-namespace.yaml
kubectl -n litellm create secret generic litellm-secrets \
  --from-literal=LITELLM_MASTER_KEY="$LITELLM_MASTER_KEY" \
  --from-literal=LITELLM_SALT_KEY="$LITELLM_SALT_KEY" \
  --from-literal=POSTGRES_PASSWORD="$POSTGRES_PASSWORD" \
  --from-literal=DATABASE_URL="$DATABASE_URL" \
  --from-literal=OPENAI_API_KEY="$OPENAI_API_KEY"
kubectl apply -f litellm-all.yaml
```

Or apply the components separately after creating the namespace and secret:

```sh
kubectl apply -f postgres-pvc.yaml
kubectl apply -f postgres-service.yaml
kubectl apply -f postgres-deployment.yaml
kubectl apply -f litellm-config.yaml
kubectl apply -f litellm-deployment.yaml
kubectl apply -f litellm-service.yaml
kubectl apply -f litellm-ingress.yaml
```

## Check and use

```sh
kubectl rollout status deployment/postgres -n litellm
kubectl rollout status deployment/litellm -n litellm
kubectl get ingress -n litellm
curl http://litellm.k8s.orb.local/health/readiness
```

Open `http://litellm.k8s.orb.local/ui` and sign in as `admin` with
`$LITELLM_MASTER_KEY`. Use the Admin UI to add models, generate virtual keys,
and inspect tracked spend.

Generate a virtual key with a USD 1 budget through the API:

```sh
curl http://litellm.k8s.orb.local/key/generate \
  -H "Authorization: Bearer $LITELLM_MASTER_KEY" \
  -H "Content-Type: application/json" \
  -d '{"models":["gpt-5.6-terra"],"max_budget":1}'
```

Use the returned virtual key for OpenAI-compatible requests:

```sh
curl http://litellm.k8s.orb.local/v1/chat/completions \
  -H "Authorization: Bearer $LITELLM_MASTER_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model":"gpt-5.6-terra","messages":[{"role":"user","content":"Say hello in five words."}]}'
```

## Delete sample app

```sh
kubectl delete namespace litellm
unset LITELLM_MASTER_KEY LITELLM_SALT_KEY POSTGRES_PASSWORD DATABASE_URL OPENAI_API_KEY
```
