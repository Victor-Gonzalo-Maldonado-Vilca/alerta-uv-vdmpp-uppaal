/* P1 (RF3, invariante de LecturaUV): toda lectura aceptada como Operativo esta en [0, INDICE_MAX]. */
A[] Central.operativo imply (lec_indice >= 0 && lec_indice <= INDICE_MAX)

/* P2 (RF5 y RF6, seguridad): ninguna alerta existe sin una lectura Operativo con indice >= UMBRAL_ALERTA, y su nivel coincide con Clasificar. */
A[] forall (i : id_t) (!Alerta(i).inicio imply (hist_est[alerta_lect[i]] == OPERATIVO && hist_ind[alerta_lect[i]] >= UMBRAL_ALERTA && alerta_nivel[i] == clasificar(hist_ind[alerta_lect[i]]) && alerta_nivel[i] >= MUY_ALTO))

/* P3 (RF7, sin omisiones): cada vez que la central queda esperando, toda lectura de riesgo registrada tiene su alerta. */
A[] Central.esperando imply forall (k : lect_t) ((k < n && hist_est[k] == OPERATIVO && hist_ind[k] >= UMBRAL_ALERTA) imply exists (i : id_t) (!Alerta(i).inicio && alerta_lect[i] == k))

/* P4 (RF8, orden del ciclo): ninguna alerta llega a Atendida sin haber pasado por Emitida. */
A[] forall (i : id_t) (Alerta(i).Atendida imply emitida[i])

/* P5 (RF8, plazo): una alerta nunca permanece Pendiente mas de T_EMITIR unidades de tiempo. */
A[] forall (i : id_t) (Alerta(i).Pendiente imply Alerta(i).x <= T_EMITIR)

/* P6 (ausencia de bloqueos): el sistema solo se detiene cuando proceso todas las lecturas y no deja alertas a medias. */
A[] deadlock imply (n == MAX_LECT && Sensor.Fin && Central.esperando && forall (i : id_t) (Alerta(i).inicio || Alerta(i).Atendida))

/* P7 (alcanzabilidad): existe una ejecucion en la que una alerta completa su ciclo hasta Atendida. */
E<> Alerta(0).Atendida

/* P8 (alcanzabilidad): es posible que todas las lecturas sean de riesgo y se creen N_ALERTAS alertas. */
E<> total == N_ALERTAS

/* P9 (sin falsas alarmas): existe una ejecucion completa en la que nunca se crea una alerta. */
E[] forall (i : id_t) Alerta(i).inicio

/* P10 (debe ser FALSA): no es alcanzable una alerta originada por una lectura fuera de rango. */
E<> exists (i : id_t) (!Alerta(i).inicio && hist_est[alerta_lect[i]] == FUERA_DE_RANGO)

/* P11 (vivacidad): toda alerta Pendiente termina siendo Emitida. */
Alerta(0).Pendiente --> Alerta(0).Emitida

