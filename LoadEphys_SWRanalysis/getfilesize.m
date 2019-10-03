function filesize = getfilesize(fid)

fopen(fid,0,'eof');
filesize = ftell(fid);
fseek(fid,0,'bof');

end