

import { z } from 'zod';

export type TPerson =
	{
		name :
			string;
		parents :
			Set<
				TPerson
			>;
	};

export const Person : z.ZodType<TPerson> = z.lazy(() => 
	z.object({
		name :
			z.string(),
		parents :
			z.set(
				Person
			),
	}));
