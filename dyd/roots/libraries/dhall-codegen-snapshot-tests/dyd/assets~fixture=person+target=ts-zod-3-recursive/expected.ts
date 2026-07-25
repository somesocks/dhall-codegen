

import { z } from 'zod';

export type TPerson =
	{
		birth_date :
			/** ISO 8601 calendar date */
			string;
		created_at :
			/** RFC 3339 date-time */
			string;
		date_of_birth :
			/** date of birth */
			Date;
		friends :
			/** friends */
			Array<
				TPerson
			>;
		name :
			/** full name */
			string;
		contact_email ?:
			/** contact email (we might not have this) */
			string;
	};

export const Person : z.ZodType<TPerson> = z.lazy(() => 
	z.object({
		birth_date :
			z.string().date().describe("ISO 8601 calendar date"),
		created_at :
			z.string().datetime({ offset: true }).describe("RFC 3339 date-time"),
		date_of_birth :
			z.date().describe("date of birth"),
		friends :
			z.array(
				Person
			).describe("friends"),
		name :
			z.string().describe("full name"),
		contact_email :
			z.string().email().describe("contact email (we might not have this)").optional(),
	}));
