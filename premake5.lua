project "GLFW"
	kind "StaticLib"
	language "C"
	staticruntime "off"
	cppdialect "C++20"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"include/GLFW/glfw3.h",
		"include/GLFW/glfw3native.h",
		"src/glfw_config.h",
		"src/context.c",
		"src/init.c",
		"src/input.c",
		"src/monitor.c",

		"src/null_init.c",
		"src/null_joystick.c",
		"src/null_monitor.c",
		"src/null_window.c",
		
		
		"src/egl_context.c",
		"src/osmesa_context.c",

		"src/platform.c",
		"src/vulkan.c",
		"src/window.c",
	}



	
	filter "system:macosx"

		systemversion "latest"
		
		files
		{
			"src/cocoa_init.m",
			"src/cocoa_monitor.m",
			"src/cocoa_window.m",
			"src/cocoa_time.c",
			"src/cocoa_joystick.m",			
			"src/posix_thread.c",
			"src/posix_module.c",
			"nsgl_context.m"
			
		}

		defines
		{
			"_GLFW_COCOA"
		}

	filter "system:linux"
		pic "On"

		systemversion "latest"
		
		files
		{
			"src/x11_init.c",
			"src/x11_monitor.c",
			"src/x11_window.c",
			"src/xkb_unicode.c",
			"src/posix_time.c",
			"src/posix_thread.c",
			"src/glx_context.c",
			"src/linux_joystick.c"
		}

		defines
		{
			"_GLFW_X11"
		}

	filter "system:windows"
		systemversion "latest"

		files
		{
			"src/win32_init.c",
			"src/win32_joystick.c",
			"src/win32_module.c",
			"src/win32_monitor.c",
			"src/win32_time.c",
			"src/win32_thread.c",
			"src/win32_window.c",
			"src/wgl_context.c"
		}

		defines 
		{ 
			"_GLFW_WIN32",
			"_CRT_SECURE_NO_WARNINGS"
		}

		links
		{
			"Dwmapi.lib"
		}
		
		
	filter "configurations:Editor_Debug"
		runtime "Debug"
		symbols "On"		
		
	filter "configurations:Editor_Release"
		runtime "Release"
		optimize "On"
		symbols "off"
		
	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"
		postbuildcommands	{	"{COPYDIR} \"%{cfg.targetdir}/%{prj.name}.lib\" \"%{wks.location}/projectmodule/Lib\""	}
		
	filter "configurations:Release"
		runtime "Release"
		optimize "on"
		postbuildcommands	{	"{COPYDIR} \"%{cfg.targetdir}/%{prj.name}.lib\" \"%{wks.location}/projectmodule/Lib\""	}
		
    filter "configurations:Dist"
		runtime "Release"
		optimize "on"
        symbols "off"		
		postbuildcommands	{	"{COPYDIR} \"%{cfg.targetdir}/%{prj.name}.lib\" \"%{wks.location}/projectmodule/Lib\""	}