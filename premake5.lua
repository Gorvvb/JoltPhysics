project "Jolt"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"Jolt/**.h",
		"Jolt/**.cpp"
	}

	includedirs
	{
		"." -- headers resolve as <Jolt/Jolt.h> against the repo root
	}

	-- The settings defines below mirror Jolt's CMake defaults (and are PUBLIC there):
	-- every translation unit that includes Jolt headers must use the same values, so
	-- Waffle/premake5.lua carries a matching set. Keep the two in sync.
	defines
	{
		"JPH_DISABLE_CUSTOM_ALLOCATOR"
	}

	filter "system:windows"
		systemversion "latest"

	filter "system:linux"
		pic "On"

	filter "configurations:Debug"
		defines
		{
			"JPH_DEBUG",
			"JPH_FLOATING_POINT_EXCEPTIONS_ENABLED",
			"JPH_DEBUG_RENDERER",
			"JPH_PROFILE_ENABLED"
		}

	filter "configurations:Release"
		defines
		{
			"JPH_FLOATING_POINT_EXCEPTIONS_ENABLED",
			"JPH_DEBUG_RENDERER",
			"JPH_PROFILE_ENABLED"
		}

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		runtime "Release"
		optimize "on"
		symbols "off"
