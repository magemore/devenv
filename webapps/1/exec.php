<?php

require_once 'auto_refresh/short.php';

class Exec {
	
	private $files = [];
	private $total = false;

	public function __construct($shellCommand=false)
	{
		$a = wrapper_over_exec($shellCommand);
		if (strpos(strtolower($a[0]),'total')!==FALSE) {
			$this->total = $a[0];
			unset($a[0]);
		}
		$this->files=$a;
		return $this;
	}

	private function prepare($files) {
        /**
         * fortmat. spluts string by colums
         */
        function clean() {

        }
	    foreach ($files as $file) {

        }
    }

	public function get() {
	 	return ['total'=>$this->total,$this->files];
	}
		
}

function getExecFiles($shellCommand) {
	return (new Exec($shellCommand))->get();
}
