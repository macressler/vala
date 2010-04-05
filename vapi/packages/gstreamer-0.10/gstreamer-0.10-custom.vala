/* gstreamer-0.10-custom.vala
 *
 * Copyright (C) 2007-2008  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */
namespace Gst {
	public extern void init ([CCode (array_length_pos = 0.9)] ref unowned string[] args);

	public struct ClockTime : uint64 {
		[CCode (cname="GST_TIME_ARGS")]
		public unowned string args ();
		[CCode (cname="GST_CLOCK_TIME_IS_VALID")]
		public bool is_valid ();
	}

	public struct ClockTimeDiff : int64 {
	}

	[Compact]
	public class ClockID {
		public ClockID.single_shot (Gst.Clock clock, Gst.ClockTime time);
		public ClockID.periodic (Gst.Clock clock, Gst.ClockTime start_time, Gst.ClockTime interval);
	}

	[CCode (ref_function = "gst_event_ref", unref_function = "gst_event_unref")]
	public class Event : MiniObject {
		public Event @ref ();
		public void unref ();
		public static void replace (ref Event? oldobj, Event? newobj);
        	public Event copy ();

		[CCode (cname = "GST_EVENT_SRC")]
		public unowned Gst.Object src ();
		[CCode (cname = "GST_EVENT_TYPE")]
		public EventType type ();
		[CCode (cname = "GST_EVENT_IS_UPSTREAM")]
		public bool is_upstream ();
		[CCode (cname = "GST_EVENT_IS_DOWNSTREAM")]
		public bool is_downstream ();
		[CCode (cname = "GST_EVENT_IS_SERIALIZED")]
		public bool is_serialized ();

		// Deprecated, should be in Gst.EventType
		public static Gst.EventTypeFlags type_get_flags (Gst.EventType type);
		public static unowned string type_get_name (Gst.EventType type);
		public static GLib.Quark type_to_quark (Gst.EventType type);
	}

#if 0
	// FIXME: This can't be parsed by vapigen, see bug #614543
	public enum EventType {
		;
		[CCode (cname = "gst_event_type_get_flags")]
		public Gst.EventTypeFlags get_flags ();
		[CCode (cname = "gst_event_type_to_quark")]
		public GLib.Quark to_quark ();
		[CCode (cname = "gst_event_type_get_name")]
		public unowned string get_name ();
	}
#endif

#if 0
	// FIXME: This can't be parsed by vapigen
	public enum Format {
		;
		[CCode (cname = "gst_format_get_details")]
		public unowned FormatDefination get_details ();
		[CCode (cname = "gst_format_to_quark")]
		public GLib.Quark to_quark ();
		[CCode (cname = "gst_format_get_name")]
		public unowned string get_name ();

		[CCode (cname = "gst_format_register")]
		static Format register (string nick, string description);
		[CCode (cname = "gst_format_get_by_nick")]
		static Format get_by_nick (string nick);
	
		[CCode (cname = "GST_FORMAT_PERCENT_MAX")]
		public const int64 PERCENT_MAX;
		[CCode (cname = "GST_FORMAT_PERCENT_SCALE")]
		public const int64 PERCENT_SCALE;
	}
#endif

	public interface ImplementsInterface : Gst.Element {
		public unowned Gst.Element? cast (GLib.Type type);
		public bool check (GLib.Type type);
	}

	public class Index {
		public int new_group ();
		[CCode (cname = "GST_INDEX_IS_WRITABLE")]
		public bool is_writable ();
		[CCode (cname = "GST_INDEX_IS_READABLE")]
		public bool is_readable ();
	}

	public struct IndexAssociation {
		public Gst.Format format;
		public int64 value;
	}

	[Compact]
	public class IndexEntry {
		public IndexEntryType type;
		[CCode (cname = "GST_INDEX_NASSOCS")]
		public int n_assocs ();
		[CCode (cname = "GST_INDEX_ASSOC_FLAGS")]
		public AssocFlags assoc_flags ();
		[CCode (cname = "GST_INDEX_ASSOC_FORMAT")]
		public Gst.Format assoc_format (int i);
		[CCode (cname = "GST_INDEX_ASSOC_VALUE")]
		public unowned IndexAssociation assoc_value (int i);
		[CCode (cname = "GST_INDEX_FORMAT_FORMAT")]
		public Gst.Format format_format ();
		[CCode (cname = "GST_INDEX_FORMAT_KEY")]
		public unowned string format_key ();
		[CCode (cname = "GST_INDEX_ID_INVALID")]
		static const int ID_INVALID;
		[CCode (cname = "GST_INDEX_ID_DESCRIPTION")]
		public unowned string id_description ();
	}

	[CCode (ref_function = "gst_object_ref", unref_function = "gst_object_unref", ref_sink_function = "gst_object_ref_sink")]
	public class Object {
		public Gst.Object @ref ();
		public void unref ();
		public void sink ();
		public void ref_sink ();
		public static void replace (ref Gst.Object? oldobj, Gst.Object? newobj);
	}

	public class Bin {
		public void add_many (params owned Gst.Element[] elements);
		public void remove_many (params Gst.Element[] elements);
	}

	[CCode (ref_function = "gst_buffer_ref", unref_function = "gst_buffer_unref")]
	public class Buffer : Gst.MiniObject {
		[CCode (has_construct_function = false)]
		public Buffer ();
		[CCode (cname = "GST_BUFFER_FLAG_SET")]
		public void flag_set (BufferFlag flag);
		[CCode (cname = "GST_BUFFER_FLAG_UNSET")]
		public void flag_unset (BufferFlag flag);
		[CCode (cname = "GST_BUFFER_FLAG_IS_SET")]
		public bool flag_is_set (BufferFlag flag);
		[CCode (cname = "GST_BUFFER_IS_DISCONT")]
		public bool is_discont ();
		[ReturnsModifiedPointer]
		public void make_metadata_writable ();
		[ReturnsModifiedPointer]
		public void make_writable ();
		[CCode (cname = "GST_BUFFER_TIMESTAMP_IS_VALID")]
		public bool timestamp_is_valid ();
		[CCode (cname = "GST_BUFFER_DURATION_IS_VALID")]
		public bool duration_is_valid ();
		[CCode (cname = "GST_BUFFER_OFFSET_IS_VALID")]
		public bool offset_is_valid ();
		[CCode (cname = "GST_BUFFER_OFFSET_END_IS_VALID")]
		public bool offset_end_is_valid ();
		[ReturnsModifiedPointer]
		public void join (owned Buffer buf2);

		public Buffer @ref ();
		public void unref ();
		public static void replace (ref Buffer? oldobj, Buffer? newobj);
        	public Buffer copy ();
	}

	[CCode (ref_function = "gst_buffer_list_ref", unref_function = "gst_buffer_list_unref")]
	public class BufferList : Gst.MiniObject {
		[ReturnsModifiedPointer]
		public void make_writable ();
		public BufferList @ref ();
		public void unref ();
        	public BufferList copy ();
	}

	public class Bus {
		[CCode (cname = "gst_bus_add_watch_full")]
		public uint add_watch (owned Gst.BusFunc func, [CCode (pos = 0.1)] int priority = GLib.Priority.DEFAULT);
		[CCode (instance_pos = -1)]
		public Gst.BusSyncReply sync_signal_handler (Gst.Bus bus, Gst.Message message);

		[CCode (instance_pos = -1)]
		public bool async_signal_func (Gst.Bus bus, Gst.Message message);
	}

	public interface ChildProxy : Gst.Object {
		public void @get (string first_property_name, ...);
		public void get_property (string name, ref Gst.Value value);
		public void get_valist (string first_property_name, void* var_args);
		public bool lookup (string name, out Gst.Object? target, out unowned GLib.ParamSpec? pspec);
		public void @set (string first_property_name, ...);
		public void set_property (string name, Gst.Value value);
		public void set_valist (string first_property_name, void* var_args);
	}

	public abstract class Element {
		[CCode (cname = "abidata.ABI.target_state")]
		public State target_state;
	}

	[CCode (cheader_filename = "gst/gst.h")]
	public class Pad {
		[CCode (array_length_pos = 0, delegate_target_pos = 0)]
		public Pad (string name, Gst.PadDirection direction);

		public uint add_buffer_probe (BufferProbeCallback handler);
		public uint add_buffer_probe_full (BufferProbeCallback handler, GLib.DestroyNotify notify);
		public uint add_data_probe (DataProbeCallback handler);
		public uint add_data_probe_full (DataProbeCallback handler, GLib.DestroyNotify notify);
		public uint add_event_probe (EventProbeCallback handler);
		public uint add_event_probe_full (EventProbeCallback handler, GLib.DestroyNotify notify);
	}

	[CCode (cname="GCallback")]
	public delegate bool BufferProbeCallback (Gst.Pad pad, Gst.Buffer buffer);
	[CCode (cname="GCallback")]
	public delegate bool EventProbeCallback (Gst.Pad pad, Gst.Event event);
	[CCode (cname="GCallback")]
	public delegate bool DataProbeCallback (Gst.Pad pad, Gst.MiniObject data);

	public class Caps {
		public Caps @ref ();
		public void unref ();

		[ReturnsModifiedPointer]
		public void make_writable ();

		[CCode (cname = "GST_CAPS_IS_SIMPLE")]
		public bool is_simple ();

		public static void replace (ref Caps? oldobj, Caps? newobj);
	}

	public class MiniObject {
		[ReturnsModifiedPointer]
		public void make_writable ();

        	public virtual MiniObject copy ();
		public virtual void finalize ();
		public static void replace (ref MiniObject? oldobj, MiniObject? newobj);
	}

	[CCode (ref_function = "gst_message_ref", unref_function = "gst_message_unref")]
	public class Message : MiniObject {
		[ReturnsModifiedPointer]
		public void make_writable ();
		public Message @ref ();
		public void unref ();
        	public Message copy ();
	}

	[CCode (ref_function = "gst_query_ref", unref_function = "gst_query_unref")]
	public class Query : MiniObject {
		[ReturnsModifiedPointer]
		public void make_writable ();
		public Query @ref ();
		public void unref ();
        	public Query copy ();
	}

	[Compact]
	[Immutable]
	[CCode (copy_function = "gst_structure_copy", type_id = "GST_TYPE_STRUCTURE", cheader_filename = "gst/gst.h")]
	public class Structure {
		[CCode (cname = "gst_structure_empty_new", has_construct_function = false)]
		public Structure.empty (string name);
		[CCode (cname = "gst_structure_id_empty_new", has_construct_function = false)]
		public Structure.id_empty (GLib.Quark quark);
	}

#if 0
	// FIXME: vapigen can't extend enums, see EventType
	public enum State {
		;
		[CCode (cname = "GST_STATE_GET_NEXT")]
		public State get_next (State pending);
	}

	public enum StateChange {
		;
		[CCode (cname = "GST_STATE_TRANSITION")]
		public static StateChange transition (State cur, State next);
		[CCode (cname = "GST_STATE_TRANSITION_CURRENT")]
		public static State transition_current ();
		[CCode (cname = "GST_STATE_TRANSITION_NEXT")]
		public static State transition_next ();
	}
#endif

	[Compact]
	public class DebugCategory {
		[CCode (cname="GST_DEBUG_CATEGORY_INIT")]
		public void init (string name, uint color, string description);
		[CCode (cname="GST_CAT_LOG")]
		public void log (string format, ...);
		[CCode (cname="GST_CAT_DEBUG")]
		public void debug (string format, ...);
		[CCode (cname="GST_CAT_INFO")]
		public void info (string format, ...);
		[CCode (cname="GST_CAT_WARNING")]
		public void warning (string format, ...);
		[CCode (cname="GST_CAT_ERROR")]
		public void error (string format, ...);
		[CCode (cname="GST_CAT_LOG_OBJECT")]
		public void log_object (GLib.Object obj, string format, ...);
		[CCode (cname="GST_CAT_DEBUG_OBJECT")]
		public void debug_object (GLib.Object obj, string format, ...);
		[CCode (cname="GST_CAT_INFO_OBJECT")]
		public void info_object (GLib.Object obj, string format, ...);
		[CCode (cname="GST_CAT_WARNING_OBJECT")]
		public void warning_object (GLib.Object obj, string format, ...);
		[CCode (cname="GST_CAT_ERROR_OBJECT")]
		public void error_object (GLib.Object obj, string format, ...);
		[CCode (cname="GST_DEBUG_CATEGORY_GET")]
		public static unowned DebugCategory @get (string name);
	}

	[CCode (cname="GST_DEBUG_BIN_TO_DOT_FILE")]
	public static void debug_bin_to_dot_file (Bin bin, DebugGraphDetails details, string prefix);
	[CCode (cname="GST_DEBUG_BIN_TO_DOT_FILE_WITH_TS")]
	public static void debug_bin_to_dot_file_with_ts (Bin bin, DebugGraphDetails details, string prefix);

	public struct IntRange {}
	public struct DoubleRange {}
	public struct List {}
	public struct Array {}
	public struct Fraction {}
	public struct FractionRange {}

	[CCode (cname = "GValue", type_id = "G_TYPE_VALUE")]
	public struct Value : GLib.Value {

		public static GLib.Type array_get_type ();
		public static GLib.Type list_get_type ();

		[CCode (cname = "GST_MAKE_FOURCC")]
		public static uint make_fourcc (char a, char b, char c, char d);
		[CCode (cname = "GST_STR_FOURCC")]
		public static uint str_fourcc (string str);

		public void set_fourcc (uint fourcc);
		public uint get_fourcc ();

		public void set_int_range (int start, int end);
		public int get_int_range_min ();
		public int get_int_range_max ();

		public void set_double_range (double start, double end);
		public double get_double_range_min ();
		public double get_double_range_max ();

		public void  list_append_value (Gst.Value append_value);
		public void  list_prepend_value (Gst.Value prepend_value);
		public void list_concat (Gst.Value value1, Gst.Value value2);
		public uint list_get_size ();
		public unowned Gst.Value? list_get_value (uint index);

		public void set_fraction (int numerator, int denominator);
		public int get_fraction_numerator ();
		public int get_fraction_denominator ();
		public static bool fraction_multiply (GLib.Value product, GLib.Value factor1, GLib.Value factor2);
		public static bool fraction_subtract (GLib.Value dest, GLib.Value minuend, GLib.Value subtrahend);

		public void set_fraction_range (Gst.Value start, Gst.Value end);
		public unowned Gst.Value? get_fraction_range_min ();
		public unowned Gst.Value? get_fraction_range_max ();
		public void set_fraction_range_full (int numerator_start, int denominator_start, int numerator_end, int denominator_end);

		public void set_date (GLib.Date date);
		public GLib.Date get_date ();

		public void set_caps (Caps caps);
		public Caps get_caps ();

		public void set_structure (Structure structure);
		public unowned Structure get_structure ();

		public unowned Buffer get_buffer ();
		public void set_buffer (Buffer b);
		public void take_buffer (Buffer b);

		public bool is_fixed ();

		public static void register (Gst.ValueTable table);

		public void init_and_copy (Gst.Value src);

		public string serialize ();
		public bool deserialize (string src);

		public static bool can_compare (Gst.Value value1, Gst.Value value2);
		public static int compare (Gst.Value value1, Gst.Value value2);

		public static void register_union_func (GLib.Type type1, GLib.Type type2, Gst.ValueUnionFunc func);
		public static bool union (Gst.Value dest, Gst.Value value1, Gst.Value value2);
		public static bool can_union (Gst.Value value1, Gst.Value value2);

		public static void register_subtract_func (GLib.Type minuend_type, GLib.Type subtrahend_type, Gst.ValueSubtractFunc func);
		public static bool subtract (Gst.Value dest, Gst.Value minuend, Gst.Value subtrahend);
		public static bool can_subtract (Gst.Value minuend, Gst.Value subtrahend);

		public static void register_intersect_func (GLib.Type type1, GLib.Type type2, Gst.ValueIntersectFunc func);
		public static bool intersect (Gst.Value dest, Gst.Value value1, Gst.Value value2);
		public static bool can_intersect (Gst.Value value1, Gst.Value value2);

		public void array_append_value (Gst.Value append_value);
		public uint array_get_size ();
		public unowned Gst.Value? array_get_value (uint index);
		public void array_prepend_value (Gst.Value prepend_value);
	}

	public class XML {
		public bool parse_doc(void* doc, string root);
		public bool parse_file(string fname, string root);
		public unowned Element get_element(string name);
	}

	[CCode (cheader_filename = "gst/gst.h")]
	public struct PluginDesc {
		public int major_version;
		public int minor_version;
		public weak string name;
		public weak string description;
		public weak Gst.PluginInitFunc plugin_init;
		public weak string version;
		public weak string license;
		public weak string source;
		public weak string package;
		public weak string origin;
		void *_gst_reserved[];
	}
}
