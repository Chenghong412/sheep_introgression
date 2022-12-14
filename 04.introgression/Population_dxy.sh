python ~/Software/SlidD/genomics_general-master/popgenWindows.py \
        -g ~/01.input/chr_Goat${1}.geno.gz \
        -f phased \
        --windType coordinate \
        -o out/chr${1}.species.Dist.20k.gz \
        -w 20000 \
        -s 10000 \
        -p Thinhorn CAOD-THH01,CAOD-THH02 \
        -p Bighorn CAOC-BIH01,CAOC-BIH02,CAOC-BIH03 \
        -p Agarli KGOM-AGL01,KGOM-AGL02,KGOM-AGL03,KGOM-AGL04,KGOM-AGL05,KGOM-AGL06,KGOM-AGL07,KGOM-AGL50,KGOM-AGL51,KGOM-AGL52,KGOM-AGL53,KGOM-AGL54 \
        -p Urial IROO-VIG01,IROO-VIG02,IROO-VIG03,IROO-VIG04,IROO-VIG05,IROO-VIG06 \
        -p Mouflon IROO-ORI01,IROO-ORI02,IROO-ORI03,IROO-ORI04,IROO-ORI05,IROO-ORI06,IROO-ORI07,IROO-ORI08,IROO-ORI09,IROO-ORI10,IROO-ORI11,IROO-ORI12,IROO-ORI13,IROO-ORI14,IROO-ORI15,IROO-ORI16,IROO-ORI18,IROO-AMU01,IROO-AMU02,IROO-AMU03,IROO-AMU04,IROO-AMU05,IROO-AMU06,IROO-AMU08,IROO-AMU09,IROO-AMU10,IROO-AMU11,IROO-AMU12,IROO-AMU13,IROO-AMU15,IROO-AMU16 \
        -p EU-Mouflon EUOO-MUS01,EUOO-MUS50,EUOO-MUS51 \
        -p AF-OA AOOA-AWD02,AOOA-AWD03,ZAOA-RDA01,ZAOA-RDA02,ZAOA-NQA01,ETOA-EMZ01,MAOA-LOC01,MAOA-LOC02,MAOA-LOC03,MAOA-LOC04,MAOA-LOC05,MAOA-LOC06,MAOA-LOC07,MAOA-LOC08,MAOA-LOC09,MAOA-LOC10,MAOA-DMN01,MAOA-DMN02,MAOA-SAD01,MAOA-SAD02,MAOA-BJD01,MAOA-TIM01,MAOA-TIM02,MAOA-BEG01,MAOA-OLD01,MAOA-OLD02 \
        -p AM-OA BROA-BCS01,BROA-BCS02,BROA-BMN01,BROA-BMN02,BROA-BSI01,BROA-BSI02,USOA-GCN01,USOA-GCN02 \
        -p AU-MRN AUOA-AUM01,AUOA-AUM02,AUOA-AUM03,AUOA-AUM04,AUOA-AUM05,AUOA-AUM06,AUOA-AUM07,AUOA-AUM08,AUOA-AUM09,AUOA-AUM10,AUOA-POD01 \
        -p CN-BYK CNOA-BYK21,CNOA-BYK22,CNOA-BYK23,CNOA-BYK24,CNOA-BYK25,CNOA-BYK26,CNOA-BYK27,CNOA-BYK28,CNOA-BYK29,CNOA-BYK30 \
        -p CN-CLB CNOA-CLB21,CNOA-CLB22,CNOA-CLB23,CNOA-CLB24,CNOA-CLB25,CNOA-CLB26,CNOA-CLB27,CNOA-CLB28,CNOA-CLB29,CNOA-CLB30 \
        -p CN-HU CNOA-HUS01,CNOA-HUS02,CNOA-HUS03,CNOA-HUS04,CNOA-HUS05,CNOA-HUS06,CNOA-HUS07,CNOA-HUS08,CNOA-HUS09,CNOA-HUS10 \
        -p CN-OLA CNOA-OLA05,CNOA-OLA06,CNOA-OLA07,CNOA-OLA08,CNOA-OLA09,CNOA-OLA10,CNOA-OLA11,CNOA-OLA12,CNOA-OLA13,CNOA-OLA14 \
        -p CN-STH CNOA-STH01,CNOA-STH02,CNOA-STH03,CNOA-STH04,CNOA-STH05,CNOA-STH06,CNOA-STH07,CNOA-STH08,CNOA-STH09 \
        -p CN-TAN CNOA-TAN01,CNOA-TAN02,CNOA-TAN03,CNOA-TAN04,CNOA-TAN05,CNOA-TAN06,CNOA-TAN07,CNOA-TAN08,CNOA-TAN09,CNOA-TAN10,CNOA-TAN11,CNOA-TAN12,CNOA-TAN13,CNOA-TAN14,CNOA-TAN15,CNOA-TAN16,CNOA-TAN17,CNOA-TAN18 \
        -p CN-PRT CNOA-PRT01,CNOA-PRT02,CNOA-PRT03,CNOA-PRT04,CNOA-PRT05,CNOA-PRT06,CNOA-PRT07,CNOA-PRT08,CNOA-PRT09,CNOA-PRT10 \
        -p CN-VLT CNOA-VLT01,CNOA-VLT02,CNOA-VLT03,CNOA-VLT04,CNOA-VLT05,CNOA-VLT06,CNOA-VLT07,CNOA-VLT08,CNOA-VLT09,CNOA-VLT10 \
        -p CN-WZM CNOA-WZM01,CNOA-WZM02,CNOA-WZM03,CNOA-WZM04,CNOA-WZM05,CNOA-WZM06,CNOA-WZM07,CNOA-WZM08,CNOA-WZM09,CNOA-WZM10 \
        -p CN-YNS CNOA-YNS03,CNOA-YNS10,CNOA-YNS19,CNOA-YNS20,CNOA-YNS23,CNOA-YNS25,CNOA-YNS26,CNOA-YNS27,CNOA-YNS28,CNOA-YNS30,CNOA-YNS31,CNOA-YNS33,CNOA-YNS34,CNOA-YNS35,CNOA-YNS37,CNOA-YNS49 \
        -p TR-OA TROA-KRS01,TROA-KRS02,TROA-KRS03,TROA-NDZ01,TROA-NDZ02,TROA-SKZ01,TROA-SKZ02,TROA-CCS01,TROA-AWT01,TROA-AWT02,TROA-AWT03 \
        -T 12 \
        --writeFailedWindows 
#-g Input genotypes file, -w Window size in bases, -s Step size for sliding window
#-p Pop name and optionally sample names (separated by commas)

