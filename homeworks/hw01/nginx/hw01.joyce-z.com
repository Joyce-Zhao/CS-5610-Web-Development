
server {
	listen 80 ;
	listen [::]:80 ;

	root /home/joyce/www/hw01.joyce-z.com;

	# Add index.php to the list if you are using PHP
	index index.html index.htm index.nginx-debian.html;

	server_name hw01.joyce-z.com;

	location / {
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		try_files $uri $uri/ =404;
	}

}


