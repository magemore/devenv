<?php

// for lazy next line
define('n', "\n");

// short for file get contnents
function g($s) {
	return file_get_contents($s);
}

function sf($s, $v) {
	return file_put_contents($s, $v);
}

// short for printr
function p($a) {
	print_r($a);
	echo n;
}

function wrapper_over_exec($c) {
	$o = [];
	exec($c, $o);
	if (!$o) {
		return [];
	}

	if (!is_array($o)) {
		return [$o];
	}

	return $o;
}

function ex($c) {
	return wrapper_over_exec($c);
}

function s1($c) {
	$a = ex($c);
	return current($a);
}

// if false than echo like php
function system_exec_wrapper($cmd, $return = false) {
	$s = ex($cmd);
	if ($return) {
		return implode(n, $s);
	} else {
		echo implode(n, $s);
	}
}

function s($c, $r = false) {
	return system_exec_wrapper($c, $r);
}

function sr($c) {
	return s($c, true);
}

// explode and return last
function get_last_line($del, $s) {
	$a = explode($del, $s);
	if (count($a) < 2) {
		return '';
	}

	return end($a);
}

function el($del, $s) {
	return get_last_line($del, $s);
}
