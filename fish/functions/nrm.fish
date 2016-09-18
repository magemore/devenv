function nrm
	if test (count $argv) -gt 0;
        echo 'delete from notes where id =' $argv | mysql -uroot -pq1234e twitter 2>/dev/null
    else
        echo 'please specify id'
    end
end
