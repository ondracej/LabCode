a=LH(valid_inds);
b=local_wave(valid_inds);
bb=~isnan(b);
aa=~isnan(a);
cc=aa & bb;
corrcoef(a(cc),b(cc))