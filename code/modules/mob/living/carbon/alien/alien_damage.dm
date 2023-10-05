/mob/living/carbon/alien/ex_act(severity)

	if(!blinded)
		flash_eyes()

	var/b_loss = null
	var/f_loss = null
	switch (severity)
		if(600 to INFINITY)
			b_loss += 500
			gib()
			return

		if(300 to 600)

			b_loss += 60

			f_loss += 60

			ear_damage += 30
			ear_deaf += 120

		if(150 to 300)
			b_loss += 30
			if (prob(50))
				Paralyse(1)
			ear_damage += 15
			ear_deaf += 60

	adjustBruteLoss(b_loss)
	adjustFireLoss(f_loss)

	updatehealth()
