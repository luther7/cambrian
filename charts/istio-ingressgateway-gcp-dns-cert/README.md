# Istio Ingress Gateway GCP DNS Certificate Helm Chart

This chart is intended to provide Istio ingress gateway with SSL certificates
issued using LetsEncrypt and Google Cloud DNS.

It deploys:
- A LetsEncrypt DNS01 cert-manager issuer using GCP Cloud DNS.
- A certificate issued using the issuer.
- An Istio Gateway selecting the Istio Ingress Gateway and using the certificate.

It assumes that you are have installed Istio with the Ingress Gateway and
bundled cert-manager. For example, the following values could have been used on
the istio chart:
```yaml
certmanager:
  enabled: true
  email: admin@example.com

gateways:
  istio-ingressgateway:
    loadBalancerIP: 1.2.3.4
```


