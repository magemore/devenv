<?php

require_once 'auto_refresh/short.php';


class Exec {
	
	private $raw = [];
	private $total = false;

	public function __construct($shellCommand=false)
	{
		$a = wrapper_over_exec($shellCommand);
		if (strpos(strtolower($a[0]),'total')!==FALSE) {
			$this->total = $a[0];
			unset($a[0]);
		}
		$this->raw=$a;
		return $this;
	}
	
	public function get() {
	 	return ['total'=>$this->total,$rows);
	}
		
}


function getExecFiles($shellCommand) {
	return (new Exec($shellCommand))->get();
}
