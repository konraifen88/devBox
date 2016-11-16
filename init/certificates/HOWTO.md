# How to get the needed certificate

Hint: Certificate is only needed when using proxy setting!

1. Go with your Browser to:

	https://dseasb33srnrn.cloudfront.net/
	
(Hint: The company certificates have to be installed in the current browser!)

1. Download the root certificate in DER format.
1. Convert the certificate from cer to pem using

	openssl x509 -inform der -in certificate.cer -out certificate.pem
	
1. Rename your certificate.pem to certificate.crt and save it to <project_root>/init/certificates

