

import { z } from 'zod';

export type TPerson =
	{
		appointment_time :
			/** RFC 3339 time */
			string;
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
		retention_period :
			/** ISO 8601 duration */
			string;
		contact_email ?:
			/** contact email (we might not have this) */
			string;
	};

export const Person : z.ZodType<TPerson> = z.lazy(() => 
	z.object({
		appointment_time :
			z.string().regex(/^(?:[01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](?:[.][0-9]+)?(?:Z|[+-](?:[01][0-9]|2[0-3]):[0-5][0-9])$/).describe("RFC 3339 time"),
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
		retention_period :
			z.string().duration().describe("ISO 8601 duration"),
		contact_email :
			z.string().email().describe("contact email (we might not have this)").optional(),
	}));
