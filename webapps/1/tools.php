<?php

require_once 'auto_refresh/short.php';


class Exec {
	
	private $raw;

	public function __construct($shellCommand=false) {
		$this->raw = wrapper_over_exec($shellCommand);
		return $this;
	}
	
	public function get() {
	 	return $this->raw;
	}
		
}


function getExecFiles($shellCommand) {
	return (new Exec($shellCommand))->get();
}