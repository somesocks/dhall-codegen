

import { z } from 'zod';

export type TPerson =
	{
		appointment_time :
			/** RFC 3339 time */
			string;
		binary_data :
			/** RFC 4648 Base64 */
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
		destination_ip :
			/** IPv6 address */
			string;
		friends :
			/** friends */
			Array<
				TPerson
			>;
		id :
			/** RFC 4122 UUID */
			string;
		name :
			/** full name */
			string;
		phone_number :
			/** E.164 telephone number */
			string;
		retention_period :
			/** ISO 8601 duration */
			string;
		source_ip :
			/** IPv4 address */
			string;
		token :
			/** RFC 4648 Base64url */
			string;
		contact_email ?:
			/** contact email (we might not have this) */
			string;
	};

export const Person : z.ZodType<TPerson> = z.lazy(() => 
	z.object({
		appointment_time :
			z.string().regex(/^(?:[01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9](?:[.][0-9]+)?(?:Z|[+-](?:[01][0-9]|2[0-3]):[0-5][0-9])$/).describe("RFC 3339 time"),
		binary_data :
			z.string().regex(/^(?:[A-Za-z0-9+\u002F]{4})*(?:[A-Za-z0-9+\u002F]{2}(?:==)?|[A-Za-z0-9+\u002F]{3}=?)?$/).describe("RFC 4648 Base64"),
		birth_date :
			z.string().date().describe("ISO 8601 calendar date"),
		created_at :
			z.string().datetime({ offset: true }).describe("RFC 3339 date-time"),
		date_of_birth :
			z.date().describe("date of birth"),
		destination_ip :
			z.string().ip({ version: "v6" }).describe("IPv6 address"),
		friends :
			z.array(
				Person
			).describe("friends"),
		id :
			z.string().uuid().describe("RFC 4122 UUID"),
		name :
			z.string().describe("full name"),
		phone_number :
			z.string().regex(/^[+][1-9][0-9]{0,14}$/).describe("E.164 telephone number"),
		retention_period :
			z.string().duration().describe("ISO 8601 duration"),
		source_ip :
			z.string().ip({ version: "v4" }).describe("IPv4 address"),
		token :
			z.string().regex(/^(?:[A-Za-z0-9_-]{4})*(?:[A-Za-z0-9_-]{2}(?:==)?|[A-Za-z0-9_-]{3}=?)?$/).describe("RFC 4648 Base64url"),
		contact_email :
			z.string().email().describe("contact email (we might not have this)").optional(),
	}));
