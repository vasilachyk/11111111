<?php

	// Автор: NexT
	error_reporting(E_ALL ^E_WARNING ^E_NOTICE); 

	// Масивчег
	$data = array();
	
	// Настройки
	$data['id'] = '38675779';
	$data['domain'] = 'l2meganet.org.ua';
	$data['timeEnd'] = 1587223306;
	
	// Не менять!
	$secretKey = 'kc21uc29y38xy78y*@G#UCHNUYT#x0^T^&!^&#2fmj83e'; 
	
	// Генерируем ключик
	$data = @serialize($data);
	mcrypt_get_iv_size(MCRYPT_BLOWFISH, MCRYPT_MODE_ECB);
	$iv = $iv_size = mcrypt_create_iv($iv_size, MCRYPT_RAND);
	$encryptData = mcrypt_encrypt(MCRYPT_BLOWFISH, $secretKey, $data, MCRYPT_MODE_ECB, $iv);

	// Пишем содержимое обратно в файл
	file_put_contents('license', $encryptData);
	
	// Сообщение
	echo 'OK';
	
?>
