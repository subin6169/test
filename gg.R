#문제1)
#다)
data.use <- mutate(seoul_gen,
                   m_total = m10+ m20 + m30 + m40+ m50, m60over,
                   f_total = f10+ f20 + f30 + f40 + f50 +f60over,
                   mf_total = m_total + f_total)
View(data.use)
data.major <- mutate(data.use,
                     ma_m <- names(m))